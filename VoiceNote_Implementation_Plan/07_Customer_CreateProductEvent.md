# Step 7: Update CreateProductEvent

## Overview
Now we need to add an event to handle setting voice note information during product creation.

## Instructions

### 7.1. Update CreateProductEvent Class
Open `customer/lib/application/products/create/create_product_event.dart` and add a new event:

```dart
@freezed
abstract class CreateProductEvent with _$CreateProductEvent {
  // Existing events...
  
  // Add this new event
  const factory CreateProductEvent.setVoiceNote({
    required String? path,
    required int? duration,
  }) = _SetVoiceNote;
}
```

## Expected Result
The CreateProductEvent should now include a new event type:
- `setVoiceNote`: For setting or clearing the voice note path and duration

## Notes
- This event will be dispatched when a user records or deletes a voice note
- The parameters are nullable to allow clearing the voice note
- This follows the existing pattern of events in the app
