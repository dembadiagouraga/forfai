<?php
declare(strict_types=1);

namespace App\Services\CategoryServices;

use App\Helpers\ResponseError;
use App\Models\Category;
use App\Models\Settings;
use App\Services\CoreService;
use App\Traits\SetTranslations;
use DB;
use Illuminate\Support\Facades\Log;
use Throwable;

class CategoryService extends CoreService
{
    use SetTranslations;

    protected function getModelClass(): string
    {
        return Category::class;
    }

    /**
     * @param array $data
     * @return array
     */
    public function create(array $data = []): array
    {
        try {
            DB::transaction(function () use ($data) {
                /** @var Category $category */
                $data['type'] = data_get(Category::TYPES, data_get($data, 'type', 1));

                if (Settings::where('key', 'category_auto_approve')->first()?->value) {
                    $data['active'] = true;
                    $data['status'] = Category::PUBLISHED;
                }

                $category = $this->model()->create($data);

                if (is_array(data_get($data, 'meta'))) {
                    $category->setMetaTags($data);
                }

                $this->setTranslations($category, $data);

                if ($category && data_get($data, 'images.0')) {
                    $category->update(['img' => data_get($data, 'images.0')]);
                    $category->uploads(data_get($data, 'images'));
                }
            });

            return ['status' => true, 'code' => ResponseError::NO_ERROR];
        } catch (Throwable $e) {
            $this->error($e);
            return [
                'status'  => false,
                'code'    => ResponseError::ERROR_501,
                'message' => __('errors.' . ResponseError::ERROR_501, locale: $this->language)
            ];
        }
    }

    /**
     * @param string $uuid
     * @param array $data
     * @return array
     */
    public function update(string $uuid, array $data = []): array
    {
        try {
            /** @var Category $category */
            $category = $this->model()->firstWhere('uuid', $uuid);

            $data['type'] = data_get(Category::TYPES, data_get($data, 'type', 1));

            $category->update($data);

            if (data_get($data, 'meta')) {
                $category->setMetaTags($data);
            }

            $this->setTranslations($category, $data);

            if (data_get($data, 'images.0')) {
                $category->galleries()->delete();
                $category->update(['img' => data_get($data, 'images.0')]);
                $category->uploads(data_get($data, 'images'));
            }

            return ['status' => true, 'code' => ResponseError::NO_ERROR];
        } catch (Throwable $e) {
            $this->error($e);
            return [
                'status'  => false,
                'code'    => ResponseError::ERROR_502,
                'message' => __('errors.' . ResponseError::ERROR_502, locale: $this->language)
            ];
        }
    }

    /**
     * @param string $uuid
     * @param array $data
     * @return array
     */
    public function changeInput(string $uuid, array $data = []): array
    {
        try {
            $category = $this->model()->firstWhere('uuid', $uuid);

            $category->update($data);

            return ['status' => true, 'code' => ResponseError::NO_ERROR];
        } catch (Throwable $e) {
            $this->error($e);
            return [
                'status'  => false,
                'code'    => ResponseError::ERROR_502,
                'message' => __('errors.' . ResponseError::ERROR_502, locale: $this->language)
            ];
        }
    }

    /**
     * @param string $uuid
     * @return array
     */
    public function changeActive(string $uuid): array
    {
        try {
            /** @var Category $category */
            $category = $this->model();
            $category = $category
                ->where('uuid', $uuid)
                ->first();

            $category->update([
                'active' => !$category->active
            ]);

            return ['status' => true, 'code' => ResponseError::NO_ERROR];
        } catch (Throwable $e) {
            $this->error($e);
            return [
                'status'  => false,
                'code'    => ResponseError::ERROR_502,
                'message' => __('errors.' . ResponseError::ERROR_502, locale: $this->language)
            ];
        }
    }

    /**
     * @param array|null $ids
     * @return array
     */
    public function delete(?array $ids = []): array
    {
        $categories = Category::with('children')
            ->whereIn('id', is_array($ids) ? $ids : [])
            ->get();

        foreach ($categories as $category) {
            /** @var Category $category */
            try {
                // First delete all children recursively
                $this->deleteChildrenRecursively($category);
                // Then delete the parent category
                $category->delete();
            } catch (Throwable $e) {
                // Log the error
                Log::error('Error deleting category: ' . $e->getMessage());
            }
        }

        return [
            'status' => true,
            'code'   => ResponseError::NO_ERROR
        ];
    }

    /**
     * Delete all children of a category recursively
     * @param Category $category
     * @return void
     */
    private function deleteChildrenRecursively($category): void
    {
        // Load children if not already loaded
        if (!$category->relationLoaded('children')) {
            $category->load('children');
        }

        // Delete all children recursively
        foreach ($category->children as $child) {
            $this->deleteChildrenRecursively($child);
            $child->delete();
        }
    }

}
