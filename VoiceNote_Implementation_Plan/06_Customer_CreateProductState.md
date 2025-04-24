# Step 6: Update CreateProductState

## Overview
Now we need to update the CreateProductState to store voice note information during product creation.

## Instructions

### 6.1. Update CreateProductState Class
Open `customer/lib/application/products/create/create_product_state.dart` and make the following changes:

#### 6.1.1. Add Fields
Add these fields to the CreateProductState class:
```dart
String? voiceNotePath;
int? voiceNoteDuration;
```

#### 6.1.2. Update Factory Method
Update the initial factory method to include the new fields:
```dart
factory CreateProductState.initial() => const CreateProductState(
  // Existing initial values...
  voiceNotePath: null,
  voiceNoteDuration: null,
);
```

#### 6.1.3. Update copyWith Method
Make sure the copyWith method includes the new fields:
```dart
CreateProductState copyWith({
  // Existing parameters...
  String? voiceNotePath,
  int? voiceNoteDuration,
}) {
  return CreateProductState(
    // Existing fields...
    voiceNotePath: voiceNotePath ?? this.voiceNotePath,
    voiceNoteDuration: voiceNoteDuration ?? this.voiceNoteDuration,
  );
}
```

## Expected Result
The CreateProductState should now be able to:
- Store the local path to a recorded voice note
- Store the duration of the voice note in seconds
- Initialize these fields as null
- Copy these fields when using copyWith

## Notes
- This update ensures the product creation flow can handle voice notes
- The state changes are backward compatible and won't affect existing functionality
- We use nullable types to handle products without voice notes
