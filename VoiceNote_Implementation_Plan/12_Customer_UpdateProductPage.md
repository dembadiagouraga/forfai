# Step 12: Update ProductPage

## Overview
Now we need to add the VoiceNotePlayer to the product detail page.

## Instructions

### 12.1. Update ProductPage
Open `customer/lib/presentation/pages/products/product_detail/product_page.dart` and make the following changes:

#### 12.1.1. Add Import
Add this import at the top of the file:
```dart
import 'package:quick/presentation/components/voice_note_player.dart';
```

#### 12.1.2. Add Method to Build Voice Note Player
Add this method to the ProductPage class:
```dart
Widget _buildVoiceNote(ProductDetailState state) {
  final product = state.product;
  
  if (product == null || product.voiceNoteUrl == null) {
    return const SizedBox.shrink();
  }
  
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
    child: VoiceNotePlayer(
      audioUrl: product.voiceNoteUrl!,
      duration: product.voiceNoteDuration ?? 0,
    ),
  );
}
```

#### 12.1.3. Add Voice Note Player to the UI
Find the product description section in the build method, and add the voice note player after it:

```dart
// Find the product description section
if (state.product?.description != null) ...[
  ProductDescription(description: state.product!.description!),
],

// Add this after the product description
_buildVoiceNote(state),
```

## Expected Result
The product detail page should now:
- Display a voice note player if the product has a voice note
- Show nothing if the product doesn't have a voice note
- Allow users to play and pause the voice note

## Notes
- This change only adds a new section to the product detail page
- Existing sections and functionality remain unchanged
- The layout follows the existing pattern with proper spacing
- The voice note player is only shown if a voice note exists
