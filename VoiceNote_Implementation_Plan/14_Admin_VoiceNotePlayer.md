# Step 14: Update Admin Product Detail View

## Overview
Now we need to update the admin product detail view to show voice notes.

## Instructions

### 14.1. Update Product Detail View
Open `admin/src/views/products/product-details.js` and make the following changes:

#### 14.1.1. Add Import
Add this import at the top of the file:
```jsx
import VoiceMessageBubble from '../../components/VoiceMessageBubble';
```

#### 14.1.2. Add Method to Render Voice Note
Add this method to render the voice note:
```jsx
const renderVoiceNote = () => {
  if (!product.voice_note_url) {
    return null;
  }
  
  return (
    <Card className="mb-4">
      <CardHeader>
        <h5>Voice Description</h5>
      </CardHeader>
      <CardBody>
        <VoiceMessageBubble 
          audioUrl={product.voice_note_url}
          duration={product.voice_note_duration || 0}
          isAdmin={false}
        />
      </CardBody>
    </Card>
  );
};
```

#### 14.1.3. Add Voice Note to the UI
Find an appropriate place in the render method to add the voice note player:
```jsx
{/* Add voice note player */}
{renderVoiceNote()}
```

### 14.2. Verify VoiceMessageBubble Component
Make sure the VoiceMessageBubble component can handle product voice notes. If needed, update it to support the same format as chat voice messages.

## Expected Result
The admin product detail view should now:
- Display a voice note player if the product has a voice note
- Show nothing if the product doesn't have a voice note
- Allow admins to play and pause the voice note

## Notes
- This implementation reuses the existing VoiceMessageBubble component
- The voice note is only shown if it exists
- The implementation follows the existing UI pattern with cards
