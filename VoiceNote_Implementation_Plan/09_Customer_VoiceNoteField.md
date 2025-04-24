# Step 9: Create VoiceNoteField Widget

## Overview
Now we need to create a widget for recording and previewing voice notes in the product creation form.

## Instructions

### 9.1. Create VoiceNoteField Widget
Create a new file at `customer/lib/presentation/pages/products/create/widgets/voice_note_field.dart` with the following content:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick/application/products/create/create_product_bloc.dart';
import 'package:quick/infrastructure/service/app_helpers.dart';
import 'package:quick/infrastructure/service/tr_keys.dart';
import 'package:quick/infrastructure/service/voice_chat_helper.dart';
import 'package:quick/presentation/pages/chat/widget/voice_recorder_widget.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VoiceNoteField extends StatelessWidget {
  const VoiceNoteField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CreateProductBloc>().state;
    final voiceChatHelper = VoiceChatHelper();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppHelpers.getTranslation(TrKeys.addVoiceDescription),
          style: Style.interNormal(
            size: 12,
            color: Style.black,
          ),
        ),
        8.verticalSpace,
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Style.borderColor),
          ),
          padding: EdgeInsets.all(12.r),
          child: Column(
            children: [
              if (state.voiceNotePath != null) ...[
                // Show recorded voice note with option to play or re-record
                _buildRecordedVoicePreview(context, state, voiceChatHelper),
              ] else ...[
                // Show record button
                ElevatedButton.icon(
                  onPressed: () => _showVoiceRecorder(context),
                  icon: Icon(Icons.mic),
                  label: Text(AppHelpers.getTranslation(TrKeys.recordVoiceMessage)),
                  style: ElevatedButton.styleFrom(
                    primary: Style.primaryColor,
                    minimumSize: Size(double.infinity, 45.h),
                  ),
                ),
                8.verticalSpace,
                Text(
                  AppHelpers.getTranslation(TrKeys.voiceNoteMaxDuration),
                  style: Style.interNormal(
                    size: 10,
                    color: Style.textColor,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecordedVoicePreview(
    BuildContext context, 
    CreateProductState state, 
    VoiceChatHelper voiceChatHelper
  ) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 8.r),
            decoration: BoxDecoration(
              color: Style.greyColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(Icons.mic, color: Style.primaryColor),
                8.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppHelpers.getTranslation(TrKeys.voiceMessage),
                        style: Style.interNormal(
                          size: 14,
                          color: Style.black,
                        ),
                      ),
                      Text(
                        voiceChatHelper.formatDuration(state.voiceNoteDuration ?? 0),
                        style: Style.interNormal(
                          size: 12,
                          color: Style.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Play the recorded voice note
                    final messageId = 'product_preview';
                    if (VoiceChatHelper.currentlyPlayingMessageId.value == messageId) {
                      voiceChatHelper.pauseVoiceMessage();
                      VoiceChatHelper.currentlyPlayingMessageId.value = null;
                    } else {
                      if (VoiceChatHelper.currentlyPlayingMessageId.value != null) {
                        voiceChatHelper.stopVoiceMessage();
                      }
                      
                      voiceChatHelper.playVoiceMessage(
                        messageId: messageId,
                        audioUrl: state.voiceNotePath!,
                      );
                      
                      VoiceChatHelper.currentlyPlayingMessageId.value = messageId;
                    }
                  },
                  icon: ValueListenableBuilder<String?>(
                    valueListenable: VoiceChatHelper.currentlyPlayingMessageId,
                    builder: (context, playingId, _) {
                      final isPlaying = playingId == 'product_preview';
                      return Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Style.primaryColor,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        8.horizontalSpace,
        IconButton(
          onPressed: () {
            // Remove the recorded voice note
            context.read<CreateProductBloc>().add(
                  CreateProductEvent.setVoiceNote(
                    path: null,
                    duration: null,
                  ),
                );
          },
          icon: Icon(Icons.delete, color: Style.red),
        ),
      ],
    );
  }

  void _showVoiceRecorder(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Style.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppHelpers.getTranslation(TrKeys.recordVoiceMessage),
                style: Style.interSemi(
                  size: 16,
                  color: Style.black,
                ),
              ),
              16.verticalSpace,
              VoiceRecorderWidget(
                onRecordingComplete: (path, duration) {
                  Navigator.pop(context);
                  if (path != null) {
                    // Validate recording duration
                    if (duration < 3) {
                      // Recording too short
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppHelpers.getTranslation(TrKeys.recordingTooShort)),
                          backgroundColor: Style.red,
                        ),
                      );
                      return;
                    }
                    
                    context.read<CreateProductBloc>().add(
                          CreateProductEvent.setVoiceNote(
                            path: path,
                            duration: duration,
                          ),
                        );
                  } else {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppHelpers.getTranslation(TrKeys.errorRecordingVoice)),
                        backgroundColor: Style.red,
                      ),
                    );
                  }
                },
                maxDuration: 120, // 2 minutes max
                onError: (error) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error),
                      backgroundColor: Style.red,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Expected Result
The VoiceNoteField widget should:
- Show a button to record a voice note when no recording exists
- Show a preview of the recorded voice note with play/pause and delete options
- Open a bottom sheet with the VoiceRecorderWidget when recording
- Validate the recording duration (minimum 3 seconds)
- Show appropriate error messages
- Use the existing VoiceChatHelper for playback

## Notes
- This widget uses the existing VoiceRecorderWidget and VoiceChatHelper
- The UI follows the existing app style
- The implementation includes error handling and validation
- The widget uses BLoC for state management
