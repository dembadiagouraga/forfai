# Step 10: Update CreateProductPage

## Overview
Now we need to add the VoiceNoteField to the product creation form.

## Instructions

### 10.1. Update CreateProductPage
Open `customer/lib/presentation/pages/products/create/create_product_page.dart` and make the following changes:

#### 10.1.1. Add Import
Add this import at the top of the file:
```dart
import 'package:quick/presentation/pages/products/create/widgets/voice_note_field.dart';
```

#### 10.1.2. Add VoiceNoteField to the Form
Find the form section in the build method, and add the VoiceNoteField after the description field:

```dart
// Find the description field (usually DescribeField)
const DescribeField(),

// Add this after the description field
16.verticalSpace,
const VoiceNoteField(),
```

## Expected Result
The product creation form should now include:
- A voice note field after the description field
- The ability to record, play, and delete voice notes

## Notes
- This change only adds a new field to the form
- Existing fields and functionality remain unchanged
- The layout follows the existing pattern with proper spacing
