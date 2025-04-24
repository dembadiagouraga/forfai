# Step 3: Update ProductResource

## Overview
Now we need to update the ProductResource to include voice note fields in the API responses.

## Instructions

### 3.1. Update ProductResource.php
Open `backend/app/Http/Resources/ProductResource.php` and update the `toArray` method:

```php
/**
 * Transform the resource into an array.
 *
 * @param  \Illuminate\Http\Request  $request
 * @return array
 */
public function toArray($request)
{
    // Find the existing return array
    return [
        // Existing fields...
        
        // Add these new fields
        'voice_note_url' => $this->voice_note_url,
        'voice_note_duration' => $this->voice_note_duration,
        'has_voice_note' => !empty($this->voice_note_url),
    ];
}
```

### 3.2. Update Other Product Resources (if any)
If you have other product-related resources (like ProductListResource, etc.), update those as well to include the voice note fields.

## Expected Result
The API responses for products should now include:
- `voice_note_url`: URL to the voice note file (null if no voice note)
- `voice_note_duration`: Duration of the voice note in seconds (null if no voice note)
- `has_voice_note`: Boolean flag indicating if the product has a voice note

## Notes
- These changes ensure that the voice note data is included in API responses
- The `has_voice_note` flag makes it easy for the frontend to check if a voice note exists
- No existing functionality will be affected by these additions
