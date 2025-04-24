# Step 2: Update ProductService

## Overview
Next, we need to update the ProductService to handle voice note uploads when creating or updating products.

## Instructions

### 2.1. Update ProductService.php
Open `backend/app/Services/ProductService/ProductService.php` and make the following changes:

#### 2.1.1. Add Imports
Add these imports at the top of the file if they don't already exist:
```php
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
```

#### 2.1.2. Update Create Method
Find the `create` method and add this code before creating the product (usually before the `$product = $this->model->create($data);` line):

```php
// Handle voice note upload
if (isset($data['voice_note']) && $data['voice_note'] instanceof UploadedFile) {
    $voiceNote = $data['voice_note'];
    $voiceNotePath = $voiceNote->store('voice-notes/products', 'public');
    $data['voice_note_url'] = Storage::url($voiceNotePath);
    $data['voice_note_duration'] = $data['voice_note_duration'] ?? 0;
    
    // Remove the file from data array
    unset($data['voice_note']);
}
```

#### 2.1.3. Update Update Method
Find the `update` method and add this code before updating the product (usually before the `$item->update($data);` line):

```php
// Handle voice note upload
if (isset($data['voice_note']) && $data['voice_note'] instanceof UploadedFile) {
    // Delete old voice note if exists
    if (!empty($item->voice_note_url)) {
        $oldPath = str_replace('/storage/', '', $item->voice_note_url);
        if (Storage::disk('public')->exists($oldPath)) {
            Storage::disk('public')->delete($oldPath);
        }
    }
    
    // Upload new voice note
    $voiceNote = $data['voice_note'];
    $voiceNotePath = $voiceNote->store('voice-notes/products', 'public');
    $data['voice_note_url'] = Storage::url($voiceNotePath);
    $data['voice_note_duration'] = $data['voice_note_duration'] ?? 0;
    
    // Remove the file from data array
    unset($data['voice_note']);
} else if (isset($data['remove_voice_note']) && $data['remove_voice_note']) {
    // Delete voice note if remove flag is set
    if (!empty($item->voice_note_url)) {
        $oldPath = str_replace('/storage/', '', $item->voice_note_url);
        if (Storage::disk('public')->exists($oldPath)) {
            Storage::disk('public')->delete($oldPath);
        }
    }
    
    $data['voice_note_url'] = null;
    $data['voice_note_duration'] = null;
    unset($data['remove_voice_note']);
}
```

### 2.2. Verify Storage Configuration
Make sure your storage is properly configured for public disk:

1. Check that symbolic link exists from `public/storage` to `storage/app/public`
2. If not, run:
```bash
php artisan storage:link
```

## Expected Result
The ProductService should now be able to:
- Handle voice note file uploads when creating products
- Update or remove voice notes when updating products
- Store voice notes in the public storage disk under 'voice-notes/products' directory
- Save the URL and duration in the database

## Notes
- This implementation uses Laravel's built-in file storage system
- Voice notes are stored in the public disk for easy access
- The implementation handles cleanup of old voice notes when updating
