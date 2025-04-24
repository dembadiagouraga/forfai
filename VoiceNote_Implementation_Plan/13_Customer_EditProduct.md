# Step 13: Update Edit Product Functionality

## Overview
Now we need to update the edit product functionality to support voice notes.

## Instructions

### 13.1. Update EditProductState
Open `customer/lib/application/products/edit/edit_product_state.dart` and make the following changes:

#### 13.1.1. Add Fields
Add these fields to the EditProductState class:
```dart
String? voiceNotePath;
int? voiceNoteDuration;
```

#### 13.1.2. Update Factory Method
Update the initial factory method to include the new fields:
```dart
factory EditProductState.initial() => const EditProductState(
  // Existing initial values...
  voiceNotePath: null,
  voiceNoteDuration: null,
);
```

### 13.2. Update EditProductEvent
Open `customer/lib/application/products/edit/edit_product_event.dart` and add a new event:

```dart
@freezed
abstract class EditProductEvent with _$EditProductEvent {
  // Existing events...
  
  // Add this new event
  const factory EditProductEvent.setVoiceNote({
    required String? path,
    required int? duration,
  }) = _SetVoiceNote;
}
```

### 13.3. Update EditProductBloc
Open `customer/lib/application/products/edit/edit_product_bloc.dart` and make the following changes:

#### 13.3.1. Add Event Handler
Add a handler for the setVoiceNote event:
```dart
on<_SetVoiceNote>((event, emit) {
  emit(state.copyWith(
    voiceNotePath: event.path,
    voiceNoteDuration: event.duration,
  ));
});
```

#### 13.3.2. Update Fetch Product Logic
Find the _FetchProduct event handler and update it to set voice note fields:
```dart
on<_FetchProduct>((event, emit) async {
  // Existing code...
  
  // When setting product data in state
  emit(state.copyWith(
    // Existing fields...
    voiceNotePath: product.voiceNoteUrl,
    voiceNoteDuration: product.voiceNoteDuration,
  ));
  
  // Rest of the existing code...
});
```

#### 13.3.3. Update Edit Product Logic
Find the _EditProduct event handler and update it to include voice note data in the form data:

```dart
on<_EditProduct>((event, emit) async {
  // Existing code...
  
  // Create form data
  final formData = FormData.fromMap({
    // Existing fields...
  });
  
  // Add voice note to form data if available
  if (state.voiceNotePath != null && state.voiceNotePath!.isNotEmpty) {
    // Check if it's a new voice note (local file) or existing one (URL)
    if (!state.voiceNotePath!.startsWith('http')) {
      final voiceNoteFile = await MultipartFile.fromFile(
        state.voiceNotePath!,
        filename: 'voice_note.aac',
      );
      formData.files.add(MapEntry('voice_note', voiceNoteFile));
    }
    formData.fields.add(MapEntry('voice_note_duration', state.voiceNoteDuration.toString()));
  } else if (state.product?.voiceNoteUrl != null) {
    // If voice note was removed
    formData.fields.add(MapEntry('remove_voice_note', 'true'));
  }
  
  // Rest of the existing code...
});
```

### 13.4. Create VoiceNoteField for Edit Product
Create a new file at `customer/lib/presentation/pages/products/edit/widgets/voice_note_field.dart` with content similar to the create product version, but using EditProductBloc instead.

### 13.5. Update EditProductPage
Open `customer/lib/presentation/pages/products/edit/edit_product_page.dart` and make the following changes:

#### 13.5.1. Add Import
Add this import at the top of the file:
```dart
import 'package:quick/presentation/pages/products/edit/widgets/voice_note_field.dart';
```

#### 13.5.2. Add VoiceNoteField to the Form
Find the form section in the build method, and add the VoiceNoteField after the description field:

```dart
// Find the description field (usually DescribeField)
const DescribeField(),

// Add this after the description field
16.verticalSpace,
const VoiceNoteField(),
```

## Expected Result
The product editing functionality should now:
- Load existing voice notes when editing a product
- Allow adding, replacing, or removing voice notes
- Save voice note changes when updating a product

## Notes
- This implementation follows the same pattern as the create product functionality
- The edit functionality handles both new and existing voice notes
- The implementation includes proper cleanup of removed voice notes
