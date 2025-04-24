# Step 8: Update CreateProductBloc

## Overview
Now we need to update the CreateProductBloc to handle voice note events and include voice note data when creating products.

## Instructions

### 8.1. Update CreateProductBloc Class
Open `customer/lib/application/products/create/create_product_bloc.dart` and make the following changes:

#### 8.1.1. Add Event Handler
Add a handler for the setVoiceNote event:
```dart
on<_SetVoiceNote>((event, emit) {
  emit(state.copyWith(
    voiceNotePath: event.path,
    voiceNoteDuration: event.duration,
  ));
});
```

#### 8.1.2. Update Create Product Logic
Find the _CreateProduct event handler and update it to include voice note data in the form data:

```dart
on<_CreateProduct>((event, emit) async {
  // Existing code...
  
  // Create form data
  final formData = FormData.fromMap({
    // Existing fields...
  });
  
  // Add voice note to form data if available
  if (state.voiceNotePath != null) {
    final voiceNoteFile = await MultipartFile.fromFile(
      state.voiceNotePath!,
      filename: 'voice_note.aac',
    );
    formData.files.add(MapEntry('voice_note', voiceNoteFile));
    formData.fields.add(MapEntry('voice_note_duration', state.voiceNoteDuration.toString()));
  }
  
  // Rest of the existing code...
});
```

### 8.2. Add Required Imports
Make sure you have the necessary imports:
```dart
import 'package:dio/dio.dart';
```

## Expected Result
The CreateProductBloc should now be able to:
- Handle the setVoiceNote event to update the state
- Include voice note file and duration in the form data when creating a product

## Notes
- This implementation uses the existing FormData mechanism
- The voice note is only included if available (null check)
- The implementation follows the existing pattern for handling files
