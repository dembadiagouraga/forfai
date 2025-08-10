<?php
declare(strict_types=1);

namespace App\Services\ProductService;

use App\Helpers\ResponseError;
use App\Models\Category;
use App\Models\Product;
use App\Models\Settings;
use App\Traits\AudioConversionTrait;
use App\Traits\SetTranslations;
use Illuminate\Support\Facades\Storage;
use App\Services\CoreService;
use Throwable;

class ProductService extends CoreService
{
    use SetTranslations, AudioConversionTrait;

    protected function getModelClass(): string
    {
        return Product::class;
    }

    /**
     * @param array $data
     * @return array
     */
    public function create(array $data): array
    {
        try {

            if (
                !empty(data_get($data, 'category_id')) &&
                $this->checkIsParentCategory((int)data_get($data, 'category_id'))
            ) {
                return [
                    'status'  => false,
                    'code'    => ResponseError::ERROR_501,
                    'message' => __('errors.'. ResponseError::CATEGORY_IS_PARENT, locale: $this->language)
                ];
            }

            $autoApprove = Settings::where('key', 'product_auto_approve')->first()?->value;

            if ($autoApprove) {
                $data['status'] = Product::PUBLISHED;
                $data['active'] = true;
            }

            $data['work'] = Category::select(['work'])->find($data['category_id'])?->work ?? false;

            /** @var Product $product */
            $product = $this->model()->create($data);

            $this->setTranslations($product, $data);

            if (data_get($data, 'meta')) {
                $product->setMetaTags($data);
            }

            // Handle voice note upload
            if (request()->hasFile('voice_note')) {
                $voiceNote = request()->file('voice_note');

                // Detect actual file format from MIME type and extension
                $originalExtension = strtolower($voiceNote->getClientOriginalExtension());
                $mimeType = $voiceNote->getMimeType();
                $formatInfo = $this->getAudioFormatInfo($mimeType, $originalExtension);

                $voiceNotePath = 'media/voice-notes/' . uniqid() . '.mp3'; // Always save as MP3
                $fileContents = file_get_contents($voiceNote->getRealPath());
                $finalContentType = 'audio/mpeg';

                // Log the file details for debugging
                \Log::info("Voice note upload: Original extension: {$originalExtension}, MIME type: {$mimeType}, Detected format: {$formatInfo['extension']}");

                // Check if we need to convert to MP3 for web compatibility
                if ($formatInfo['needs_conversion']) {
                    \Log::info("Converting {$formatInfo['extension']} voice note to MP3 for web compatibility");

                    try {
                        $conversionResult = $this->convertAudioToMp3($voiceNote->getRealPath(), $formatInfo['extension']);

                        if ($conversionResult['success']) {
                            // Update file contents with converted file
                            $fileContents = file_get_contents($conversionResult['converted_path']);
                            \Log::info("Successfully converted {$formatInfo['extension']} voice note to MP3. New size: " . strlen($fileContents) . " bytes");

                            // Clean up temporary converted file
                            if (file_exists($conversionResult['converted_path'])) {
                                unlink($conversionResult['converted_path']);
                            }
                        } else {
                            \Log::warning("Voice note conversion failed: " . $conversionResult['error'] . ". Uploading original format.");
                        }
                    } catch (\Exception $e) {
                        \Log::warning("Voice note conversion exception: " . $e->getMessage() . ". Uploading original format.");
                    }
                }

                // Get voice note duration if provided
                $voiceNoteDuration = request()->input('voice_note_duration');

                try {
                    // Try to upload to S3 using AWS SDK directly
                    $s3Client = new \Aws\S3\S3Client([
                        'version' => 'latest',
                        'region' => env('AWS_DEFAULT_REGION'),
                        'credentials' => [
                            'key' => env('AWS_ACCESS_KEY_ID'),
                            'secret' => env('AWS_SECRET_ACCESS_KEY'),
                        ],
                        'http' => [
                            'verify' => false // Disable SSL verification for testing
                        ]
                    ]);

                    // Upload to S3
                    $result = $s3Client->putObject([
                        'Bucket' => env('AWS_BUCKET'),
                        'Key' => $voiceNotePath,
                        'Body' => $fileContents,
                        'ContentType' => $finalContentType,
                        'Metadata' => [
                            'original-extension' => $originalExtension,
                            'detected-format' => $formatInfo['extension'],
                            'final-format' => 'mp3',
                            'converted' => $formatInfo['needs_conversion'] ? 'true' : 'false',
                        ],
                        // No ACL parameter
                    ]);

                    // Get the URL
                    $url = $result['ObjectURL'];

                    // Save voice note URL and duration
                    $product->update([
                        'voice_note_url' => $url,
                        'voice_note_duration' => $voiceNoteDuration,
                    ]);
                } catch (\Exception $e) {
                    // If S3 upload fails, store locally
                    \Log::warning("S3 upload failed: " . $e->getMessage() . ". Storing voice note locally.");

                    // Store locally
                    $localPath = 'public/voice-notes/' . uniqid() . '.mp3';
                    Storage::put($localPath, $fileContents);

                    // Save local URL and duration
                    $product->update([
                        'voice_note_url' => rtrim(config('app.img_host'), '/') . '/' . str_replace('public/', 'storage/', $localPath),
                        'voice_note_duration' => $voiceNoteDuration,
                    ]);
                }
            }

            if (data_get($data, 'images.0')) {
                $product->update(['img' => data_get($data, 'previews.0') ?? data_get($data, 'images.0')]);
                $product->uploads(data_get($data, 'images'));
            }

            $this->updateProductAttributeValues($product, $data);

            return [
                'status' => true,
                'code'   => ResponseError::NO_ERROR,
                'data'   => $product->loadMissing(['translations', 'metaTags'])
            ];
        } catch (Throwable $e) {
            return [
                'status'  => false,
                'code'    => $e->getCode() ? 'ERROR_' . $e->getCode() : ResponseError::ERROR_400,
                'message' => $e->getMessage()
            ];
        }
    }

    /**
     * @param string $slug
     * @param array $data
     * @return array
     */
    public function update(string $slug, array $data): array
    {
        try {

            if (
                !empty(data_get($data, 'category_id')) &&
                $this->checkIsParentCategory((int)data_get($data, 'category_id'))
            ) {
                return [
                    'status'  => false,
                    'code'    => ResponseError::ERROR_501,
                    'message' => __('errors.'. ResponseError::CATEGORY_IS_PARENT, locale: $this->language)
                ];
            }

            $query = $this->model()->newQuery();

            if (request()->is('api/v1/dashboard/user/*')) {
                $query->where('user_id', auth('sanctum')->id());
            }

            $product = $query->where('slug', $slug)->first();

            if (empty($product)) {
                return ['status' => false, 'code' => ResponseError::ERROR_404];
            }

            $data['status_note'] = null;
            $data['work'] = Category::select(['work'])->find($data['category_id'])?->work ?? false;

            /** @var Product $product */
            $product->update($data);

            $this->setTranslations($product, $data);

            if (data_get($data, 'meta')) {
                $product->setMetaTags($data);
            }

            // Handle voice note upload
            if (request()->hasFile('voice_note')) {
                // Delete old voice note if exists
                if ($product->voice_note_url) {
                    $oldPath = str_replace(env('AWS_URL') . '/', '', $product->voice_note_url);
                    Storage::disk('s3')->delete($oldPath);
                }

                $voiceNote = request()->file('voice_note');

                // Detect actual file format from MIME type and extension
                $originalExtension = strtolower($voiceNote->getClientOriginalExtension());
                $mimeType = $voiceNote->getMimeType();
                $formatInfo = $this->getAudioFormatInfo($mimeType, $originalExtension);

                $voiceNotePath = 'media/voice-notes/' . uniqid() . '.mp3'; // Always save as MP3
                $fileContents = file_get_contents($voiceNote->getRealPath());
                $finalContentType = 'audio/mpeg';

                // Log the file details for debugging
                \Log::info("Voice note update: Original extension: {$originalExtension}, MIME type: {$mimeType}, Detected format: {$formatInfo['extension']}");

                // Check if we need to convert to MP3 for web compatibility
                if ($formatInfo['needs_conversion']) {
                    \Log::info("Converting {$formatInfo['extension']} voice note to MP3 for web compatibility");

                    try {
                        $conversionResult = $this->convertAudioToMp3($voiceNote->getRealPath(), $formatInfo['extension']);

                        if ($conversionResult['success']) {
                            // Update file contents with converted file
                            $fileContents = file_get_contents($conversionResult['converted_path']);
                            \Log::info("Successfully converted {$formatInfo['extension']} voice note to MP3. New size: " . strlen($fileContents) . " bytes");

                            // Clean up temporary converted file
                            if (file_exists($conversionResult['converted_path'])) {
                                unlink($conversionResult['converted_path']);
                            }
                        } else {
                            \Log::warning("Voice note conversion failed: " . $conversionResult['error'] . ". Uploading original format.");
                        }
                    } catch (\Exception $e) {
                        \Log::warning("Voice note conversion exception: " . $e->getMessage() . ". Uploading original format.");
                    }
                }

                // Get voice note duration if provided
                $voiceNoteDuration = request()->input('voice_note_duration');

                // Try to upload to S3 using AWS SDK directly
                $s3Client = new \Aws\S3\S3Client([
                    'version' => 'latest',
                    'region' => env('AWS_DEFAULT_REGION'),
                    'credentials' => [
                        'key' => env('AWS_ACCESS_KEY_ID'),
                        'secret' => env('AWS_SECRET_ACCESS_KEY'),
                    ],
                    'http' => [
                        'verify' => false // Disable SSL verification for testing
                    ]
                ]);

                // Upload to S3
                $result = $s3Client->putObject([
                    'Bucket' => env('AWS_BUCKET'),
                    'Key' => $voiceNotePath,
                    'Body' => $fileContents,
                    'ContentType' => $finalContentType,
                    'Metadata' => [
                        'original-extension' => $originalExtension,
                        'detected-format' => $formatInfo['extension'],
                        'final-format' => 'mp3',
                        'converted' => $formatInfo['needs_conversion'] ? 'true' : 'false',
                    ],
                    // No ACL parameter
                ]);

                // Get the URL
                $url = $result['ObjectURL'];

                // Save voice note URL and duration
                $product->update([
                    'voice_note_url' => $url,
                    'voice_note_duration' => $voiceNoteDuration,
                ]);
            }

            if (data_get($data, 'images.0')) {
                $product->galleries()->delete();
                $product->update([ 'img' => data_get($data, 'previews.0') ?? data_get($data, 'images.0')]);
                $product->uploads(data_get($data, 'images'));
            }

            $this->updateProductAttributeValues($product, $data);

            return [
                'status' => true,
                'code'   => ResponseError::NO_ERROR,
                'data'   => $product->loadMissing(['translations', 'metaTags'])
            ];
        } catch (Throwable $e) {
            return [
                'status'  => false,
                'code'    => $e->getCode() ? 'ERROR_' . $e->getCode() : ResponseError::ERROR_400,
                'message' => $e->getMessage()
            ];
        }
    }

    /**
     * @param array|null $ids
     * @param int|null $userId
     * @return array
     */
    public function delete(?array $ids = [], ?int $userId = null): array
    {
        $products = Product::whereIn('id', $ids)
            ->when($userId, fn($q) => $q->where('user_id', $userId))
            ->get();

        $errorIds = [];

        foreach ($products as $product) {
            try {
                /** @var Product $product */
                $product->delete();
            } catch (Throwable) {
                $errorIds[] = $product->id;
            }
        }

        if (count($errorIds) === 0) {
            return ['status' => true, 'code' => ResponseError::NO_ERROR];
        }

        return ['status' => false, 'code' => ResponseError::ERROR_505, 'message' => implode(', ', $errorIds)];
    }

    /**
     * @param int|string $categoryId
     * @return bool
     */
    private function checkIsParentCategory(int|string $categoryId): bool
    {
        $parentCategory = Category::firstWhere('parent_id', $categoryId);

        return !!data_get($parentCategory, 'id');
    }

    public function setActive(string $slug, ?int $userId = null): array
    {
        $product = Product::when($userId, fn($q) => $q->where('user_id', $userId))->firstWhere('slug', $slug);

        if (empty($product)) {
            return [
                'status'  => false,
                'code'    => ResponseError::ERROR_404,
                'message' => __('errors.' . ResponseError::ERROR_404, locale: $this->language),
            ];
        }

        $product->update(['active' => !$product->active]);

        return [
            'status' => true,
            'data'   => $product
        ];
    }

    /**
     * @param string $slug
     * @param array $data
     * @return array
     */
    public function setStatus(string $slug, array $data): array
    {
        /** @var Product $product */
        $product = Product::where('slug', $slug)->first();

        if (!$product) {
            return [
                'status' => false,
                'code'   => ResponseError::ERROR_404,
                'message' => __('errors.' . ResponseError::ERROR_404, locale: $this->language)
            ];
        }

        $actual = $product->id;

        if (!$actual) {
            return [
                'status'  => false,
                'code'    => ResponseError::ERROR_430,
                'message' => __('errors.' . ResponseError::ERROR_430, locale: $this->language)
            ];
        }

        $product->update([
            'status'      => data_get($data, 'status'),
            'status_note' => data_get($data, 'status_note', '')
        ]);

        return [
            'status' => true,
            'code'   => ResponseError::NO_ERROR,
            'data'   => $product
        ];

    }

    /**
     * @param Product $product
     * @param $data
     * @return void
     */
    public function updateProductAttributeValues(Product $product, $data): void
    {

        if (!isset($data['attribute_values'])) {
            return;
        }

        $values = collect($data['attribute_values']);


        $product->attributeValueProducts()->delete();

        foreach ($values as $value) {

            $product->attributeValueProducts()->create([
                'attribute_id'       => $value['attribute_id'],
                'attribute_value_id' => $value['value_id'] ?? null,
                'value'              => $value['value'] ?? null,
            ]);

        }

    }
}
