# Step 4: Update ProductData Model

## Overview
Now we need to update the ProductData model in the customer app to include voice note fields.

## Instructions

### 4.1. Update ProductData Class
Open `customer/lib/domain/model/model/product_model.dart` and make the following changes:

#### 4.1.1. Add Fields
Add these fields to the ProductData class:
```dart
final String? voiceNoteUrl;
final int? voiceNoteDuration;
```

#### 4.1.2. Update Constructor
Update the constructor to include the new fields:
```dart
const ProductData({
  // Existing parameters...
  this.voiceNoteUrl,
  this.voiceNoteDuration,
});
```

#### 4.1.3. Update fromJson Method
Update the fromJson method to parse the new fields:
```dart
factory ProductData.fromJson(Map<String, dynamic> json) {
  return ProductData(
    // Existing fields...
    voiceNoteUrl: json['voice_note_url'],
    voiceNoteDuration: json['voice_note_duration'] != null 
      ? int.tryParse(json['voice_note_duration'].toString()) ?? 0 
      : null,
  );
}
```

#### 4.1.4. Update toJson Method
Update the toJson method to include the new fields:
```dart
Map<String, dynamic> toJson() {
  return {
    // Existing fields...
    'voice_note_url': voiceNoteUrl,
    'voice_note_duration': voiceNoteDuration,
  };
}
```

#### 4.1.5. Update copyWith Method (if exists)
If there's a copyWith method, update it to include the new fields:
```dart
ProductData copyWith({
  // Existing parameters...
  String? voiceNoteUrl,
  int? voiceNoteDuration,
}) {
  return ProductData(
    // Existing fields...
    voiceNoteUrl: voiceNoteUrl ?? this.voiceNoteUrl,
    voiceNoteDuration: voiceNoteDuration ?? this.voiceNoteDuration,
  );
}
```

## Expected Result
The ProductData model should now be able to:
- Store voice note URL and duration
- Parse these fields from JSON responses
- Include these fields when converting to JSON
- Copy these fields when using copyWith (if implemented)

## Notes
- This update ensures the customer app can handle voice note data from the API
- The model changes are backward compatible and won't affect existing functionality
- We use nullable types to handle products without voice notes
