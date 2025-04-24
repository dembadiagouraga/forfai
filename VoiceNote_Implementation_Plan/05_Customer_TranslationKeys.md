# Step 5: Add Translation Keys

## Overview
We need to add translation keys for the voice note feature to support multiple languages.

## Instructions

### 5.1. Update TrKeys Class
Open `customer/lib/infrastructure/service/tr_keys.dart` and add these constants:

```dart
// Voice note related translations
static const String addVoiceDescription = 'add.voice.description';
static const String voiceNoteMaxDuration = 'voice.note.max.duration';
static const String sellerVoiceDescription = 'seller.voice.description';
static const String recordVoiceMessage = 'record.voice.message';
static const String voiceMessage = 'voice.message';
static const String errorRecordingVoice = 'error.recording.voice';
static const String recordingTooShort = 'recording.too.short';
static const String voiceDescription = 'voice.description';
```

### 5.2. Add English Translations
Add these translations to your English translation file or database:

```
"add.voice.description": "Add voice description (max 2 min)",
"voice.note.max.duration": "Maximum duration: 2 minutes",
"seller.voice.description": "Seller's voice description",
"record.voice.message": "Record voice message",
"voice.message": "Voice message",
"error.recording.voice": "Error recording voice message",
"recording.too.short": "Recording too short. Please record at least 3 seconds",
"voice.description": "Voice description"
```

### 5.3. Add French Translations (Optional)
If you're supporting French, add these translations:

```
"add.voice.description": "Ajouter une description vocale (max 2 min)",
"voice.note.max.duration": "Durée maximale: 2 minutes",
"seller.voice.description": "Description vocale du vendeur",
"record.voice.message": "Enregistrer un message vocal",
"voice.message": "Message vocal",
"error.recording.voice": "Erreur lors de l'enregistrement du message vocal",
"recording.too.short": "Enregistrement trop court. Veuillez enregistrer au moins 3 secondes",
"voice.description": "Description vocale"
```

## Expected Result
The app should now have translation keys for all voice note related text, supporting:
- Voice note recording UI
- Voice note playback UI
- Error messages
- Informational text

## Notes
- These translations follow the existing pattern in the app
- The keys are descriptive and follow the dot notation convention
- You can add translations for other languages as needed
