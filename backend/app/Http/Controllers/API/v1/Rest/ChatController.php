<?php
declare(strict_types=1);

namespace App\Http\Controllers\API\v1\Rest;

use App\Helpers\ResponseError;
use App\Http\Controllers\API\v1\Rest\RestBaseController;
use App\Models\Settings;
use App\Traits\AudioConversionTrait;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Log;

class ChatController extends RestBaseController
{
    use AudioConversionTrait;
    /**
     * Upload voice message to AWS S3
     *
     * @param Request $request
     * @return JsonResponse
     */
    public function uploadVoiceMessage(Request $request): JsonResponse
    {
        // DEBUG: Confirm new code is running
        Log::info("🔥 NEW VOICE MESSAGE CONTROLLER RUNNING - M4A CONVERSION ENABLED");

        $validator = Validator::make($request->all(), [
            'audio' => 'required|file',
            'chat_id' => 'required|string',
            'duration' => 'required|numeric',
        ]);

        if ($validator->fails()) {
            return $this->errorResponse(
                ResponseError::ERROR_400,
                $validator->errors()->first()
            );
        }

        try {
            // Get the audio file
            $audioFile = $request->file('audio');
            $chatId = $request->input('chat_id');

            // Detect actual file format from MIME type and extension
            $originalExtension = strtolower($audioFile->getClientOriginalExtension());
            $mimeType = $audioFile->getMimeType();

            // Determine actual audio format based on MIME type and extension
            $actualFormat = $this->detectAudioFormat($mimeType, $originalExtension);
            $extension = $actualFormat['extension'];
            $contentType = $actualFormat['content_type'];

            // Generate a unique filename with correct extension
            $fileName = time() . '_' . uniqid() . '.' . $extension;

            // Log the file details for debugging
            Log::info("Voice message upload: Original extension: " . $originalExtension .
                     ", MIME type: " . $mimeType .
                     ", Detected format: " . $extension .
                     ", Content-Type: " . $contentType);

            // ✅ FIXED: Validate audio file integrity
            $validationResult = $this->validateAudioFileIntegrity($audioFile, $originalExtension, $mimeType);
            if (!$validationResult['valid']) {
                Log::warning("Invalid audio file detected: " . $validationResult['reason']);
                Log::warning("File details - Size: " . $audioFile->getSize() . ", Original name: " . $audioFile->getClientOriginalName());

                // Try to fix common issues
                if ($validationResult['fixable']) {
                    Log::info("Attempting to fix audio file format...");
                    $fixResult = $this->attemptAudioFormatFix($audioFile, $mimeType, $originalExtension);
                    if ($fixResult['success']) {
                        $extension = $fixResult['corrected_extension'];
                        $contentType = $fixResult['corrected_content_type'];
                        Log::info("Audio format corrected: " . $extension);
                    } else {
                        return $this->errorResponse(
                            ResponseError::ERROR_400,
                            "Invalid audio file format: " . $validationResult['reason']
                        );
                    }
                } else {
                    return $this->errorResponse(
                        ResponseError::ERROR_400,
                        "Invalid audio file: " . $validationResult['reason']
                    );
                }
            }

            // ✅ VOICE FILES ONLY: Force S3 for voice messages, ignore database setting
            // Voice messages always go to S3, other files follow database setting

            // Set storage options - VOICE FILES ALWAYS S3
            $options = ['disk' => 's3'];
            $disk = 's3';

            Log::info("Voice message storage: Forcing S3 for voice files only (database setting ignored)");

            // Define the path in S3
            $path = "media/voice_messages/{$chatId}/{$fileName}";

            try {
                if ($disk === 's3') {
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

                    // Log the file details for debugging
                    Log::info("S3 Upload: File size: " . filesize($audioFile->getRealPath()) .
                              ", MIME type: " . $audioFile->getMimeType() .
                              ", Original extension: " . $audioFile->getClientOriginalExtension());

                    // Verify the file is a valid audio file
                    $fileContents = file_get_contents($audioFile->getRealPath());
                    $fileSize = strlen($fileContents);

                    if ($fileSize < 100) {
                        Log::warning("Very small audio file detected: $fileSize bytes. This might not be a valid audio file.");
                    }

                    // Check if we need to convert M4A to MP3 for web compatibility
                    $needsConversion = in_array($extension, ['m4a', 'aac']);
                    $finalPath = $path;
                    $finalContentType = $contentType;
                    $finalExtension = $extension;

                    if ($needsConversion) {
                        Log::info("M4A/AAC file detected, converting to MP3 for web compatibility");

                        try {
                            $conversionResult = $this->convertAudioToMp3($audioFile->getRealPath(), $extension);

                            if ($conversionResult['success']) {
                                // Update path and content type for MP3
                                $finalPath = str_replace('.' . $extension, '.mp3', $path);
                                $finalContentType = 'audio/mpeg';
                                $finalExtension = 'mp3';

                                // Update file contents with converted file
                                $fileContents = file_get_contents($conversionResult['converted_path']);
                                $fileSize = strlen($fileContents);

                                Log::info("Successfully converted {$extension} to MP3. New size: {$fileSize} bytes");

                                // Clean up temporary converted file
                                if (file_exists($conversionResult['converted_path'])) {
                                    unlink($conversionResult['converted_path']);
                                }
                            } else {
                                Log::warning("Audio conversion failed: " . $conversionResult['error'] . ". Uploading original format.");
                            }
                        } catch (\Exception $e) {
                            Log::warning("Audio conversion exception: " . $e->getMessage() . ". Uploading original format.");
                        }
                    }

                    Log::info("Final upload format: {$finalExtension} with content-type: {$finalContentType}");

                    // Log the file details
                    Log::info("Uploading audio file to S3: {$finalPath}, size: {$fileSize} bytes, content type: {$finalContentType}");

                    try {
                        // Upload to S3 without ACL (use bucket policy instead)
                        $result = $s3Client->putObject([
                            'Bucket' => env('AWS_BUCKET'),
                            'Key' => $finalPath,
                            'Body' => $fileContents,
                            'ContentType' => $finalContentType,
                            'CacheControl' => 'max-age=86400', // 24 hours caching
                            // Removed ACL parameter - use bucket policy instead
                            'Metadata' => [
                                'original-filename' => $audioFile->getClientOriginalName(),
                                'original-extension' => $originalExtension,
                                'detected-format' => $extension,
                                'final-format' => $finalExtension,
                                'file-size' => (string)$fileSize,
                                'actual-mime-type' => $finalContentType,
                                'upload-timestamp' => (string)time(),
                                'converted' => $needsConversion ? 'true' : 'false',
                            ],
                        ]);

                        Log::info("Successfully uploaded file to S3: " . $result['ObjectURL']);
                    } catch (\Exception $e) {
                        Log::error("Error uploading file to S3: " . $e->getMessage());
                        throw $e;
                    }

                    // Use direct URL with original format
                    $directUrl = $result['ObjectURL'];
                    Log::info("Using direct URL with original format: " . $directUrl);

                    // Use the direct URL as-is (no extension manipulation)
                    $url = $directUrl;

                    // Verify the URL format
                    if (!filter_var($url, FILTER_VALIDATE_URL)) {
                        Log::warning("Invalid URL format: " . $url);
                    } else {
                        Log::info("Valid URL format: " . $url);
                    }

                    // Test the URL with a GET request to ensure it's accessible
                    try {
                        $client = new \GuzzleHttp\Client(['verify' => false]);
                        $response = $client->get($url, [
                            'timeout' => 5,
                            'headers' => [
                                'Accept' => '*/*',
                                'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
                            ]
                        ]);

                        if ($response->getStatusCode() == 200) {
                            $contentLength = $response->getHeader('Content-Length');
                            $contentType = $response->getHeader('Content-Type');

                            Log::info("Direct URL is accessible: " . $url);
                            Log::info("Content-Length: " . (isset($contentLength[0]) ? $contentLength[0] : 'unknown'));
                            Log::info("Content-Type: " . (isset($contentType[0]) ? $contentType[0] : 'unknown'));

                            // Verify the content is valid
                            $body = $response->getBody()->getContents();
                            $bodyLength = strlen($body);

                            if ($bodyLength < 100) {
                                Log::warning("Very small file content: $bodyLength bytes. This might not be a valid audio file.");
                            } else {
                                Log::info("File content size: $bodyLength bytes");
                            }
                        } else {
                            Log::warning("Direct URL returned status code: " . $response->getStatusCode());
                        }
                    } catch (\Exception $e) {
                        Log::warning("Failed to validate direct URL: " . $e->getMessage() . ". Continuing anyway.");
                    }

                    // Log final URL with actual format
                    Log::info("Final S3 URL with correct format: " . $url . " (Format: " . $extension . ")");
                } else {
                    // Store locally
                    $audioFile->storeAs(dirname($path), basename($path), $options);

                    // Generate the URL
                    $url = Storage::disk($disk)->url($path);
                }
            } catch (\Exception $e) {
                // ✅ VOICE FILES S3 FALLBACK: If S3 fails, use local storage
                Log::warning("Voice message S3 upload failed: " . $e->getMessage() . ". Falling back to local storage.");
                Log::info("S3 Fallback reason: " . get_class($e) . " - " . $e->getCode());
                Log::info("Note: Other files still use database AWS setting, only voice files forced to S3");

                // Reset to local storage configuration for voice files
                $disk = 'public';
                $options = ['disk' => 'public'];

                // ✅ ENHANCED: Use consistent path structure with S3
                $localPath = "media/voice_messages/{$chatId}/{$fileName}";

                try {
                    // ✅ ENHANCED: Create directory if it doesn't exist
                    $fullDirectoryPath = storage_path("app/public/media/voice_messages/{$chatId}");
                    if (!file_exists($fullDirectoryPath)) {
                        mkdir($fullDirectoryPath, 0755, true);
                        Log::info("Created fallback directory: " . $fullDirectoryPath);
                    }

                    // ✅ ENHANCED: Store with correct path structure and validation
                    $storedPath = $audioFile->storeAs("media/voice_messages/{$chatId}", $fileName, ['disk' => 'public']);

                    if (!$storedPath) {
                        throw new \Exception("Failed to store file locally");
                    }

                    // ✅ ENHANCED: Generate correct URL with validation
                    $url = rtrim(config('app.img_host'), '/') . '/storage/' . $localPath;

                    // Verify file was actually stored
                    $fullFilePath = storage_path("app/public/" . $localPath);
                    if (!file_exists($fullFilePath)) {
                        throw new \Exception("File not found after local storage: " . $fullFilePath);
                    }

                    Log::info("✅ Voice message successfully stored locally as fallback", [
                        'local_path' => $localPath,
                        'url' => $url,
                        'file_size' => filesize($fullFilePath)
                    ]);

                } catch (\Exception $fallbackError) {
                    Log::error("❌ Local storage fallback also failed: " . $fallbackError->getMessage());
                    return $this->errorResponse(
                        ResponseError::ERROR_500,
                        'Failed to store voice message: Both AWS S3 and local storage failed'
                    );
                }
            }

            // Get the duration from the request and ensure it's a number
            $duration = (float)$request->input('duration');

            // ✅ ENHANCED: Log complete voice message details
            Log::info("Voice message processing completed", [
                'chat_id' => $chatId,
                'file_name' => $fileName,
                'storage_disk' => $disk,
                'final_url' => $url,
                'duration' => $duration,
                'file_size' => $audioFile->getSize(),
                'original_extension' => $originalExtension,
                'final_extension' => $extension
            ]);

            // ✅ ENHANCED: Also store locally for admin panel fallback (CORS issues)
            if ($disk === 's3') {
                try {
                    $localPath = "media/voice_messages/{$chatId}/{$fileName}";
                    Storage::disk('public')->put($localPath, $fileContents);
                    $localUrl = config('app.img_host') . '/storage/' . $localPath;
                    Log::info("✅ Voice message also stored locally for admin panel fallback: $localUrl");
                } catch (\Exception $localError) {
                    Log::warning("Local backup storage failed: " . $localError->getMessage());
                    // Don't fail the request if local backup fails
                }
            }

            return $this->successResponse('Voice message uploaded successfully', [
                'url' => $url,
                'duration' => $duration, // Return the actual duration as a number
            ]);
        } catch (\Exception $e) {
            return $this->errorResponse(
                ResponseError::ERROR_400,
                $e->getMessage()
            );
        }
    }

    /**
     * Detect actual audio format from MIME type and extension
     */
    private function detectAudioFormat($mimeType, $extension)
    {
        // Priority: MIME type first, then extension as fallback

        // Check MIME type first (most reliable)
        switch ($mimeType) {
            case 'audio/mpeg':
            case 'audio/mp3':
                return ['extension' => 'mp3', 'content_type' => 'audio/mpeg'];

            case 'audio/aac':
            case 'audio/aacp':
            case 'audio/x-aac':
                return ['extension' => 'aac', 'content_type' => 'audio/aac'];

            case 'audio/mp4':
            case 'audio/m4a':
                return ['extension' => 'm4a', 'content_type' => 'audio/mp4'];

            case 'audio/wav':
            case 'audio/wave':
            case 'audio/x-wav':
                return ['extension' => 'wav', 'content_type' => 'audio/wav'];

            case 'audio/ogg':
                return ['extension' => 'ogg', 'content_type' => 'audio/ogg'];

            case 'audio/webm':
                return ['extension' => 'webm', 'content_type' => 'audio/webm'];
        }

        // Fallback to extension if MIME type is not recognized
        switch ($extension) {
            case 'mp3':
            case 'mpeg':
            case 'mpga':
                return ['extension' => 'mp3', 'content_type' => 'audio/mpeg'];

            case 'aac':
                return ['extension' => 'aac', 'content_type' => 'audio/aac'];

            case 'm4a':
            case 'mp4':
                return ['extension' => 'm4a', 'content_type' => 'audio/mp4'];

            case 'wav':
                return ['extension' => 'wav', 'content_type' => 'audio/wav'];

            case 'ogg':
                return ['extension' => 'ogg', 'content_type' => 'audio/ogg'];

            case 'webm':
                return ['extension' => 'webm', 'content_type' => 'audio/webm'];

            default:
                // Default fallback - assume MP3 for compatibility
                Log::warning("Unknown audio format: MIME={$mimeType}, Extension={$extension}. Defaulting to MP3.");
                return ['extension' => 'mp3', 'content_type' => 'audio/mpeg'];
        }
    }

    /**
     * ✅ FIXED: Validate audio file integrity
     * Checks if the file format matches the claimed extension and MIME type
     */
    private function validateAudioFileIntegrity($audioFile, $originalExtension, $mimeType): array
    {
        try {
            // Read first few bytes to check file signature
            $handle = fopen($audioFile->getPathname(), 'rb');
            $header = fread($handle, 12);
            fclose($handle);

            // Check for common format mismatches
            $isWebM = strpos($header, 'webm') !== false || $mimeType === 'video/webm';
            $isWAV = substr($header, 0, 4) === 'RIFF' && substr($header, 8, 4) === 'WAVE';
            $isMP3 = substr($header, 0, 3) === 'ID3' || (ord($header[0]) === 0xFF && (ord($header[1]) & 0xE0) === 0xE0);

            // Log file signature analysis
            Log::info("Audio file signature analysis:", [
                'header_hex' => bin2hex($header),
                'is_webm' => $isWebM,
                'is_wav' => $isWAV,
                'is_mp3' => $isMP3,
                'claimed_extension' => $originalExtension,
                'mime_type' => $mimeType
            ]);

            // Check for format mismatches
            if ($originalExtension === 'mp3' && $isWebM) {
                return [
                    'valid' => false,
                    'reason' => 'File claims to be MP3 but contains WebM data',
                    'fixable' => true,
                    'actual_format' => 'webm'
                ];
            }

            if ($originalExtension === 'wav' && $isWebM) {
                return [
                    'valid' => false,
                    'reason' => 'File claims to be WAV but contains WebM data',
                    'fixable' => true,
                    'actual_format' => 'webm'
                ];
            }

            // File appears valid
            return [
                'valid' => true,
                'reason' => 'File format appears consistent',
                'detected_format' => $isWAV ? 'wav' : ($isMP3 ? 'mp3' : ($isWebM ? 'webm' : 'unknown'))
            ];

        } catch (\Exception $e) {
            Log::error('Error validating audio file: ' . $e->getMessage());
            return [
                'valid' => false,
                'reason' => 'Could not validate file format',
                'fixable' => false
            ];
        }
    }

    /**
     * ✅ FIXED: Attempt to fix audio format issues
     */
    private function attemptAudioFormatFix($audioFile, $mimeType, $originalExtension): array
    {
        try {
            // If it's WebM data with wrong extension, correct it
            if ($mimeType === 'video/webm' || strpos($mimeType, 'webm') !== false) {
                return [
                    'success' => true,
                    'corrected_extension' => 'webm',
                    'corrected_content_type' => 'audio/webm',
                    'message' => 'Corrected WebM file extension'
                ];
            }

            return [
                'success' => false,
                'message' => 'No automatic fix available for this format mismatch'
            ];

        } catch (\Exception $e) {
            Log::error('Error fixing audio format: ' . $e->getMessage());
            return [
                'success' => false,
                'message' => 'Failed to fix audio format'
            ];
        }
    }
}
