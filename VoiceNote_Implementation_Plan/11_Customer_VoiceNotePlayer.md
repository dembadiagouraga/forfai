# Step 11: Create VoiceNotePlayer Widget

## Overview
Now we need to create a widget for playing voice notes in the product detail page.

## Instructions

### 11.1. Create VoiceNotePlayer Widget
Create a new file at `customer/lib/presentation/components/voice_note_player.dart` with the following content:

```dart
import 'package:flutter/material.dart';
import 'package:quick/infrastructure/service/app_helpers.dart';
import 'package:quick/infrastructure/service/tr_keys.dart';
import 'package:quick/infrastructure/service/voice_chat_helper.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VoiceNotePlayer extends StatelessWidget {
  final String audioUrl;
  final int duration;
  
  const VoiceNotePlayer({
    Key? key,
    required this.audioUrl,
    required this.duration,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final voiceChatHelper = VoiceChatHelper();
    final messageId = 'product_voice_note';
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
      decoration: BoxDecoration(
        color: Style.greyColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppHelpers.getTranslation(TrKeys.sellerVoiceDescription),
            style: Style.interNormal(
              size: 14,
              color: Style.textColor,
            ),
          ),
          8.verticalSpace,
          Row(
            children: [
              ValueListenableBuilder<String?>(
                valueListenable: VoiceChatHelper.currentlyPlayingMessageId,
                builder: (context, playingId, _) {
                  final isPlaying = playingId == messageId;
                  
                  return IconButton(
                    onPressed: () {
                      if (isPlaying) {
                        voiceChatHelper.pauseVoiceMessage();
                        VoiceChatHelper.currentlyPlayingMessageId.value = null;
                      } else {
                        if (VoiceChatHelper.currentlyPlayingMessageId.value != null) {
                          voiceChatHelper.stopVoiceMessage();
                        }
                        
                        voiceChatHelper.playVoiceMessage(
                          messageId: messageId,
                          audioUrl: audioUrl,
                        );
                        
                        VoiceChatHelper.currentlyPlayingMessageId.value = messageId;
                      }
                    },
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Style.primaryColor,
                    ),
                    iconSize: 32.r,
                  );
                },
              ),
              16.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Waveform visualization
                    Container(
                      height: 24.h,
                      decoration: BoxDecoration(
                        color: Style.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      voiceChatHelper.formatDuration(duration),
                      style: Style.interNormal(
                        size: 12,
                        color: Style.textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

## Expected Result
The VoiceNotePlayer widget should:
- Display a play/pause button for the voice note
- Show a simple waveform visualization
- Display the duration of the voice note
- Use the existing VoiceChatHelper for playback

## Notes
- This widget uses the existing VoiceChatHelper
- The UI follows the existing app style
- The implementation includes a simple waveform visualization
- The widget uses ValueListenableBuilder for reactive UI updates
