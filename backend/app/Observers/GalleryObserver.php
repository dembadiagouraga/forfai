<?php
declare(strict_types=1);

namespace App\Observers;

use App\Models\Gallery;
use App\Traits\Loggable;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Throwable;

class GalleryObserver
{
    use Loggable;
    /**
     * Handle the Gallery "deleted" event.
     *
     * @param Gallery $gallery
     * @return void
     */
    public function deleted(Gallery $gallery)
    {
        try {
            // Ensure we delete the physical file from the public disk
            // Gallery->path is expected like: "categories/filename.webp" or possibly already "images/categories/..."
            $relative = ltrim((string) $gallery->path, '/');

            $path = Str::startsWith($relative, 'images/') ? $relative : ('images/' . $relative);

            Storage::disk('public')->delete($path);
        } catch (Throwable $e) {
            $this->error($e);
        }
    }
}
