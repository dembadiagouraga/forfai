import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/chat/chat_bloc.dart';
import 'package:quick/domain/model/model/message_model.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/service/voice_chat_helper.dart';

import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'dart:io' show Platform;

import 'voice_recorder_widget.dart';

class SendButton extends StatefulWidget {
  final ProductData? product;
  final CustomColorSet colors;
  final VoidCallback sendMessage;
  final VoidCallback sendImage;
  final TextEditingController controller;
  final FocusNode focusNode;
  final MessageModel? replyMessage;
  final VoidCallback removeReplyMessage;
  final VoidCallback removeProduct;
  final Function(String, int)? onVoiceMessageRecorded;

  const SendButton({
    super.key,
    required this.colors,
    required this.sendMessage,
    required this.controller,
    required this.focusNode,
    this.replyMessage,
    required this.removeReplyMessage,
    required this.sendImage,
    this.product,
    required this.removeProduct,
    this.onVoiceMessageRecorded,
  });

  @override
  State<SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<SendButton> {
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = widget.focusNode.hasFocus;
    });
  }

  /// Build a voice message reply preview
  Widget _buildVoiceMessageReply(MessageModel? message) {
    // Get the duration in seconds
    final durationSeconds = int.tryParse(message?.audioDuration ?? "0") ?? 0;

    // Format the duration
    final minutes = durationSeconds ~/ 60;
    final seconds = durationSeconds % 60;
    final formattedDuration = '$minutes:${seconds.toString().padLeft(2, '0')}';

    return Row(
      children: [
        // Microphone icon
        Icon(
          Remix.mic_line,
          size: 16.r,
          color: widget.colors.textBlack,
        ),
        8.horizontalSpace,
        // Voice waveform representation
        Expanded(
          child: Container(
            height: 20.r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(8, (index) {
                // Create a simple waveform visualization
                double heightPercentage = 0.3 + (index % 3) * 0.2;

                return Container(
                  width: 2.r,
                  height: 16.r * heightPercentage,
                  margin: EdgeInsets.symmetric(horizontal: 1.r),
                  decoration: BoxDecoration(
                    color: widget.colors.textBlack.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(1.r),
                  ),
                );
              }),
            ),
          ),
        ),
        8.horizontalSpace,
        // Duration text
        Text(
          formattedDuration,
          style: CustomStyle.interNormal(
            size: 12.sp,
            color: widget.colors.textBlack,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.colors.backgroundColor,
      // Key change: use Column with mainAxisSize.min to ensure it adjusts with keyboard
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          6.verticalSpace,
          if (widget.product != null)
            Padding(
              padding: EdgeInsets.only(left: 16.r, top: 8.r, bottom: 8.r),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Icon(
                      Remix.reply_line,
                      color: widget.colors.textBlack,
                    ),
                    8.horizontalSpace,
                    const VerticalDivider(
                      color: CustomStyle.dividerColor,
                      thickness: 2,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width - 120.r,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            CustomNetworkImage(
                              url: widget.product?.img,
                              height: 56,
                              width: 62,
                              fit: BoxFit.cover,
                              radius: AppConstants.radius / 1.2,
                            ),
                            8.horizontalSpace,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.product?.translation?.title ?? "",
                                    style: CustomStyle.interNormal(
                                      size: 12,
                                      letterSpacing: -0.5,
                                      color: widget.colors.textBlack,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    AppHelpers.numberFormat(widget.product?.price),
                                    style: CustomStyle.interSemi(
                                      size: 14,
                                      letterSpacing: -0.5,
                                      color: widget.colors.textBlack,
                                    ),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                            ButtonEffectAnimation(
                              child: IconButton(
                                onPressed: widget.removeProduct,
                                icon: Icon(
                                  Remix.close_line,
                                  color: widget.colors.textBlack,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (widget.replyMessage != null)
            Padding(
              padding: EdgeInsets.only(left: 16.r, top: 8.r, bottom: 8.r),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Icon(
                      Remix.reply_line,
                      color: widget.colors.textBlack,
                    ),
                    8.horizontalSpace,
                    const VerticalDivider(
                      color: CustomStyle.dividerColor,
                      thickness: 2,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width - 120.r,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            if (widget.replyMessage?.media != null)
                              Container(
                                height: 56,
                                width: 62,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: CustomNetworkImage(
                                  url: widget.replyMessage?.media,
                                  height: 56,
                                  width: 62,
                                  fit: BoxFit.cover,
                                  radius: AppConstants.radius / 1.2,
                                ),
                              ),
                            8.horizontalSpace,
                            Expanded(
                              child: widget.replyMessage?.type == "voice"
                                ? _buildVoiceMessageReply(widget.replyMessage)
                                : Text(
                                    widget.replyMessage?.message ?? "",
                                    style: CustomStyle.interNormal(
                                      size: 12,
                                      letterSpacing: -0.5,
                                      color: widget.colors.textBlack,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            ),
                            ButtonEffectAnimation(
                              child: IconButton(
                                onPressed: widget.removeReplyMessage,
                                icon: Icon(
                                  Remix.close_line,
                                  color: widget.colors.textBlack,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Container(
            height: 54.r,
            margin: EdgeInsets.only(
                left: 16.r,
                right: 16.r,
                bottom: MediaQuery.of(context).viewInsets.bottom +
                    MediaQuery.of(context).padding.bottom +
                    (Platform.isAndroid ? 8.r : (-12.r))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text input container - flexible width with constraints
                Container(
                  width: MediaQuery.sizeOf(context).width - 90.r, // Adjusted for proper spacing
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _isFocused ? CustomStyle.primary : widget.colors.icon,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(AppConstants.radius.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      widget.product == null
                          ? // Image attachment button
                          IconButton(
                              onPressed: widget.sendImage,
                              icon: Icon(
                                Remix.attachment_2,
                                color: CustomStyle.primary, // Changed to blue to match other icons
                              ),
                            )
                          : 12.horizontalSpace,
                      Expanded(
                        child: TextFormField(
                          focusNode: widget.focusNode,
                          controller: widget.controller,
                          cursorWidth: 1.r,
                          cursorColor: widget.colors.textBlack,
                          style: CustomStyle.interNormal(
                            size: 14,
                            letterSpacing: -0.5,
                            color: widget.colors.textBlack,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: CustomStyle.interNormal(
                              size: 12,
                              letterSpacing: -0.5,
                              color: widget.colors.textHint,
                            ),
                            hintText: AppHelpers.getTranslation(TrKeys.typeSomething),
                          ),
                        ),
                      ),
                      8.horizontalSpace,
                      InkWell(
                        onTap: widget.sendMessage,
                        child: Container(
                          width: 42.r,
                          height: 42.r,
                          decoration: BoxDecoration(
                              color: widget.colors.backgroundColor, shape: BoxShape.circle),
                          child: BlocBuilder<ChatBloc, ChatState>(
                            builder: (context, state) {
                              return state.isButtonLoading
                                  ? const Loading()
                                  : Icon(
                                      Remix.send_plane_2_line,
                                      size: 26.r, // Increased size from 18.r to 22.r
                                      color: CustomStyle.primary, // Changed to blue to match border color
                                    );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // WhatsApp style mic icon with proper spacing (8.r space from text field)
                if (widget.onVoiceMessageRecorded != null)
                  SizedBox(width: 5.r), // Space between text field and mic - WhatsApp style

                if (widget.onVoiceMessageRecorded != null)
                  Container(
                    width: 52.r,
                    height: 52.r,
                    decoration: BoxDecoration(
                      color: CustomStyle.primary, // Blue color to match sender message bubbles
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // Stop any playing voice message before starting recording
                        final voiceChatHelper = VoiceChatHelper();
                        voiceChatHelper.stopVoiceMessage();

                        // Use a very short delay before showing the bottom sheet to avoid permission dialogs
                        Future.delayed(const Duration(milliseconds: 50), () {
                          if (!context.mounted) return;

                          // Show the bottom sheet with auto-starting recorder
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            isDismissible: false,
                            enableDrag: false,
                            // Set this to ensure it appears above the keyboard
                            useRootNavigator: true,
                            // Calculate position to show above keyboard
                            routeSettings: const RouteSettings(name: 'voice_recorder'),
                            builder: (context) => Padding(
                              // Add padding to position above keyboard
                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: Container(
                                height: 120, // Reduced height as requested
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                ),
                                child: VoiceRecorderWidget(
                                  onRecordingComplete: widget.onVoiceMessageRecorded!,
                                  whatsAppStyle: true,
                                  autoStart: true, // Auto-start recording without showing permission dialog
                                ),
                              ),
                            ),
                          );
                        });
                      },
                      child: Icon(
                        Remix.mic_line,
                        color: Colors.white,
                        size: 24.r,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
