import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/presentation/components/blur_wrap.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/domain/model/model/message_model.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/service/voice_chat_helper.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/media/custom_network_image.dart';
import 'package:quick/presentation/pages/chat/widget/audio_waveform.dart';
import 'package:quick/presentation/pages/chat/widget/image_chat_screen.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:just_audio/just_audio.dart' as just_audio;
import 'focused_custom_menu.dart';

class MessageItem extends StatefulWidget {
  final CustomColorSet colors;
  final MessageModel message;
  final MessageModel? replyMessage;
  final ValueChanged<String> edit;
  final ValueChanged<MessageModel> reply;
  final ValueChanged<String> delete;

  const MessageItem({
    super.key,
    required this.colors,
    required this.message,
    required this.edit,
    required this.reply,
    required this.delete,
    required this.replyMessage,
  });

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  // Map to store position notifiers for each message
  final Map<String, ValueNotifier<int>> _positionNotifiers = {};

  // Map to store stream subscriptions for each message
  final Map<String, StreamSubscription?> _streamSubscriptions = {};

  // Track if product is tapped - moved to class level
  bool _isProductTapped = false;
  
  // 🎯 TRACK LOADED VOICE MESSAGES: Prevent duplicate loading
  static final Map<String, bool> _loadedVoiceMessages = {};
  
  // 🎯 CHECK IF MESSAGE SHOULD LOAD
  bool shouldLoadVoiceMessage(String messageId) {
    // Always load if not previously loaded
    if (!_loadedVoiceMessages.containsKey(messageId)) {
      _loadedVoiceMessages[messageId] = true;
      debugPrint('🆕 New voice message will load: $messageId');
      return true;
    }
    
    debugPrint('✅ Voice message already loaded, skipping: $messageId');
    return false;
  }

  @override
  void dispose() {
    // Clean up all position notifiers
    for (final notifier in _positionNotifiers.values) {
      notifier.dispose();
    }
    _positionNotifiers.clear();

    // Cancel all stream subscriptions (including completion subscriptions)
    for (final subscription in _streamSubscriptions.values) {
      subscription?.cancel();
    }
    _streamSubscriptions.clear();

    // Stop any playing voice message when widget is disposed
    final voiceChatHelper = VoiceChatHelper();
    voiceChatHelper.stopVoiceMessage();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool owner = LocalStorage.getUser().id == widget.message.senderId;
    debugPrint('Building message: type=${widget.message.type}, owner=$owner, senderId=${widget.message.senderId}, userId=${LocalStorage.getUser().id}');
    return FocusedMenuHolder(
      menuBoxDecoration: BoxDecoration(color: widget.colors.newBoxColor),
      borderColor: widget.colors.transparent,
      menuWidth: MediaQuery.sizeOf(context).width / 2,
      menuItems: owner
          ? [
              if (widget.message.type != "image")
                _focusedItem(
                    context: context,
                    title: TrKeys.edit,
                    icon: Remix.edit_box_line,
                    onPressed: () => widget.edit(widget.message.doc ?? "")),
              if (widget.message.type != "image")
                _focusedItem(
                    context: context,
                    title: TrKeys.copy,
                    icon: Remix.file_copy_2_line,
                    onPressed: () {
                      AppHelpers.errorSnackBar(
                          context: context,
                          message:
                              AppHelpers.getTranslation(TrKeys.messageCopied));
                      Clipboard.setData(
                        ClipboardData(
                          text: widget.message.message ?? "",
                        ),
                      );
                    }),
              _focusedItem(
                  context: context,
                  title: TrKeys.reply,
                  icon: Remix.reply_line,
                  onPressed: () => widget.reply(widget.message)),
              _focusedItem(
                context: context,
                title: TrKeys.delete,
                icon: Remix.delete_bin_6_line,
                onPressed: () => widget.delete(widget.message.doc ?? ""),
                color: CustomStyle.red,
              ),
            ]
          : [
              _focusedItem(
                context: context,
                title: TrKeys.reply,
                icon: Remix.reply_line,
                onPressed: () => widget.reply(widget.message),
              ),
              if (widget.message.type != "image")
                _focusedItem(
                    context: context,
                    title: TrKeys.copy,
                    icon: Remix.file_copy_2_line,
                    onPressed: () {
                      AppHelpers.errorSnackBar(
                          context: context,
                          message:
                              AppHelpers.getTranslation(TrKeys.messageCopied));
                      Clipboard.setData(
                        ClipboardData(
                          text: widget.message.message ?? "",
                        ),
                      );
                    }),
            ],
      child: SwipeTo(
        key: UniqueKey(),
        onLeftSwipe: (dr) {
          return widget.reply(widget.message);
        },
        child: Container(
          color: widget.colors.transparent,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (owner) const Spacer(),
              widget.message.type == "image"
                  ? _image(owner, context)
                  : widget.message.type == "voice"
                      ? _voiceMessage(owner, context)
                      : _message(owner, context),
            ],
          ),
        ),
      ),
    );
  }

  FocusedMenuItem _focusedItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onPressed,
    Color? color,
  }) {
    return FocusedMenuItem(
      backgroundColor: widget.colors.newBoxColor,
      title: Text(
        AppHelpers.getTranslation(title),
        style:
            CustomStyle.interNormal(color: color ?? widget.colors.textBlack, size: 14),
      ),
      trailingIcon: Icon(icon, color: color ?? widget.colors.textBlack),
      onPressed: onPressed,
    );
  }

  Widget _image(bool owner, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ImageChatPage(image: widget.message.message ?? ""),
          ),
        );
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width * 2 / 3,
        height: MediaQuery.sizeOf(context).width * 2 / 3,
        margin: EdgeInsets.only(bottom: 8.r, left: 8.r, right: 8.r),
        padding: EdgeInsets.all(2.r),
        decoration: BoxDecoration(
          color: owner ? widget.colors.primary : widget.colors.newBoxColor,
          borderRadius: BorderRadius.circular(AppConstants.radius.r),
        ),
        child: Stack(
          children: [
            CustomNetworkImage(
              url: widget.message.message,
              height: MediaQuery.sizeOf(context).width * 2 / 3,
              width: MediaQuery.sizeOf(context).width * 2 / 3,
              radius: AppConstants.radius,
            ),
            Positioned(bottom: 8.r, right: 8.r, child: _time(owner))
          ],
        ),
      ),
    );
  }

  Widget _message(bool owner, BuildContext context) {
    return (widget.message.message?.length ?? 0) > 26 || widget.message.product != null
        ? Container(
            width: MediaQuery.sizeOf(context).width * 2 / 3,
            margin: EdgeInsets.only(bottom: 8.r, left: 8.r, right: 8.r),
            padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 12.r),
            decoration: BoxDecoration(
              color: owner ? widget.colors.primary : widget.colors.newBoxColor,
              borderRadius: BorderRadius.circular(AppConstants.radius.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.replyMessage?.doc != "") _reply(context, owner),
                if (widget.message.product != null) _productItem(context, owner),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        widget.message.message ?? "",
                        style: CustomStyle.interNormal(
                            color: owner ? widget.colors.white : widget.colors.textBlack,
                            size: 12.sp),
                      ),
                    ),
                    _time(owner)
                  ],
                ),
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.only(bottom: 8.r, left: 8.r, right: 8.r),
            padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 12.r),
            decoration: BoxDecoration(
              color: owner ? widget.colors.primary : widget.colors.newBoxColor,
              borderRadius: BorderRadius.circular(AppConstants.radius.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.replyMessage?.doc != "") _reply(context, owner),
                Row(
                  children: [
                    Text(
                      widget.message.message ?? "",
                      style: CustomStyle.interNormal(
                          color: owner ? widget.colors.white : widget.colors.textBlack,
                          size: 12.sp),
                    ),
                    _time(owner)
                  ],
                ),
              ],
            ),
          );
  }

  _time(owner) {
    return BlurWrap(
      radius: BorderRadius.circular(AppConstants.radius / 1.4),
      blur: widget.message.type == 'image' ? 12 : 0,
      child: Container(
        decoration: BoxDecoration(
            color: widget.message.type == 'image'
                ? CustomStyle.whiteWithOpacity
                : CustomStyle.transparent),
        padding: widget.message.type == 'image'
            ? REdgeInsets.symmetric(horizontal: 4, vertical: 2)
            : EdgeInsets.only(top: 15.r, left: 5.r),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              TimeService.dateFormatHM(widget.message.time),
              style: CustomStyle.interRegular(
                  color: owner ? widget.colors.white : widget.colors.textBlack, size: 10.sp),
            ),
            if (owner)
              Icon(
                widget.message.read ? Remix.check_double_line : Remix.check_line,
                size: 12.r,
                color: widget.colors.white,
              ),
          ],
        ),
      ),
    );
  }

  _reply(BuildContext context, owner) {
    return BlurWrap(
      radius: BorderRadius.circular(AppConstants.radius / 1.6),
      child: Container(
        decoration: const BoxDecoration(color: CustomStyle.whiteWithOpacity),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 4.r,
                decoration: BoxDecoration(
                  color: owner ? CustomStyle.dividerColor : CustomStyle.icon,
                ),
              ),
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: widget.replyMessage?.type == "image"
                    ? CustomNetworkImage(
                        url: widget.replyMessage?.message,
                        height: 56,
                        width: 56,
                        fit: BoxFit.contain,
                        radius: 0)
                    : (widget.replyMessage?.message?.length ?? 0) > 26
                        ? SizedBox(
                            width: MediaQuery.sizeOf(context).width * 2 / 3,
                            child: Text(
                              widget.replyMessage?.message ?? "",
                              style: CustomStyle.interNormal(
                                  color:
                                      owner ? widget.colors.white : widget.colors.textBlack,
                                  size: 12.sp),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        : Text(
                            widget.replyMessage?.message ?? "",
                            style: CustomStyle.interNormal(
                                color: owner ? widget.colors.white : widget.colors.textBlack,
                                size: 12.sp),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _productItem(BuildContext context, owner) {
    return Padding(
      padding: REdgeInsets.only(bottom: 4),
      child: GestureDetector(
        onTapDown: (_) {
          // Set tapped state to true on tap down
          setState(() {
            _isProductTapped = true;
          });
        },
        onTapUp: (_) {
          // Navigate on tap up
          Future.delayed(const Duration(milliseconds: 150), () {
            if (mounted) {
              setState(() {
                _isProductTapped = false;
              });
              ProductRoute.goProductPage(
                context: context,
                product: ProductData.fromJson(widget.message.product!.toJson()));
            }
          });
        },
        onTapCancel: () {
          // Reset tapped state if tap is canceled (e.g., during scroll)
          setState(() {
            _isProductTapped = false;
          });
        },
        child: BlurWrap(
          radius: BorderRadius.circular(AppConstants.radius / 1.4),
          child: Container(
            decoration: BoxDecoration(
              color: CustomStyle.whiteWithOpacity,
              border: Border.all(
                color: _isProductTapped ? CustomStyle.primary : Colors.transparent,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(AppConstants.radius / 1.4),
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    width: 4.r,
                    decoration: BoxDecoration(
                      color:
                          owner ? CustomStyle.dividerColor : CustomStyle.icon,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          REdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      child: Row(
                        children: [
                          CustomNetworkImage(
                            url: widget.message.product?.img,
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
                                  widget.message.product?.title ?? "",
                                  style: CustomStyle.interNormal(
                                    size: 12,
                                    letterSpacing: -0.5,
                                    color:
                                        owner ? widget.colors.white : widget.colors.textBlack,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  AppHelpers.numberFormat(
                                    widget.message.product?.price,
                                    symbol: widget.message.product?.currency,
                                  ),
                                  style: CustomStyle.interSemi(
                                    size: 14,
                                    letterSpacing: -0.5,
                                    color:
                                        owner ? widget.colors.white : widget.colors.textBlack,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
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
        ),
      ),
    );
  }

  /// Display a voice message with play button, waveform and duration
  Widget _voiceMessage(bool owner, BuildContext context) {
    // Get the voice chat helper
    final voiceChatHelper = VoiceChatHelper();

    // Get the duration in seconds - handle both string and number formats
    int durationSeconds = 0;

    // Check if this is an admin message (senderId = 1)
    bool isAdminMessage = widget.message.senderId == 1;

    // Debug info
    debugPrint('Voice message details: senderId=${widget.message.senderId}, isAdmin=$isAdminMessage, audioDuration=${widget.message.audioDuration}, duration=${widget.message.duration}');

    // Extract duration with improved logic to handle all cases correctly
    if (widget.message.duration != null) {
      // Handle duration field (works for both admin and customer messages)
      if (widget.message.duration is num) {
        durationSeconds = (widget.message.duration as num).toInt();
        debugPrint('Using duration as number: $durationSeconds');
      } else {
        durationSeconds = int.tryParse(widget.message.duration.toString()) ?? 0;
        debugPrint('Parsed duration from string: $durationSeconds');
      }
    } else if (widget.message.audioDuration != null) {
      // Fallback to audioDuration field
      durationSeconds = int.tryParse(widget.message.audioDuration!) ?? 0;
      debugPrint('Using audioDuration: $durationSeconds');
    }

    // Validate duration - use minimum of 1 second if invalid
    if (durationSeconds <= 0) {
      debugPrint('Voice message has invalid duration, using minimum of 1 second');
      durationSeconds = 1;
    }

    // Final debug log
    debugPrint('Final duration for voice message: $durationSeconds seconds');

    // Get or create a position notifier for this message
    final messageId = widget.message.doc ?? "";
    if (!_positionNotifiers.containsKey(messageId)) {
      _positionNotifiers[messageId] = ValueNotifier<int>(0);
    }
    final currentPosition = _positionNotifiers[messageId]!;

    // Create a loading state notifier
    final isLoading = ValueNotifier<bool>(false);

    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * 0.75, // Slightly larger max width
        minWidth: MediaQuery.sizeOf(context).width * 0.5,   // Minimum width for voice messages
      ),
      margin: EdgeInsets.only(bottom: 8.r, left: owner ? 0 : 8.r, right: owner ? 8.r : 0),
      padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 10.r), // Slightly reduced padding
      decoration: BoxDecoration(
        color: owner ? widget.colors.primary : widget.colors.newBoxColor,
        borderRadius: BorderRadius.circular(AppConstants.radius.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.replyMessage?.doc != "") _reply(context, owner),
          if (widget.message.product != null) _productItem(context, owner),
          // Use IntrinsicHeight to prevent overflow and better layout
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Play button - Fixed width to prevent overflow
                SizedBox(
                  width: 40.w,
                  child: ValueListenableBuilder<String?>(
                    valueListenable: VoiceChatHelper.currentlyPlayingMessageId,
                    builder: (context, currentlyPlayingId, _) {
                      final playing = currentlyPlayingId == messageId;

                      return ValueListenableBuilder<bool>(
                        valueListenable: isLoading,
                        builder: (context, loading, _) {
                          // Check if this is an uploading voice message (sent by current user)
                          final isUploadingVoiceMessage = widget.message.isUploading == true || 
                                                          (widget.message.isLocalVoiceMessage == true && owner);
                          
                          // Check if this is a voice message that needs downloading (received message without local path)
                          final needsDownload = !owner && widget.message.type == "voice" && 
                                               widget.message.media != null && 
                                               widget.message.media!.startsWith('http');

                          // Show uploading state for sent messages
                          if (isUploadingVoiceMessage) {
                            return SizedBox(
                              width: 24.r,
                              height: 24.r,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: owner ? widget.colors.white : widget.colors.primary,
                                  ),
                                  Icon(
                                    Icons.upload,
                                    size: 12.r,
                                    color: owner ? widget.colors.white : widget.colors.primary,
                                  ),
                                ],
                              ),
                            );
                          }

                          // Show download loading for received messages when downloading
                          if (loading && needsDownload) {
                            return SizedBox(
                              width: 24.r,
                              height: 24.r,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: owner ? widget.colors.white : widget.colors.textBlack,
                                  ),
                                  Icon(
                                    Icons.download,
                                    size: 12.r,
                                    color: owner ? widget.colors.white : widget.colors.textBlack,
                                  ),
                                ],
                              ),
                            );
                          }

                          // Show regular loading (for local playback)
                          if (loading) {
                            return SizedBox(
                              width: 24.r,
                              height: 24.r,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: owner ? widget.colors.white : widget.colors.textBlack,
                              ),
                            );
                          }

                          return IconButton(
                            icon: Icon(playing ? Icons.pause : Icons.play_arrow),
                            onPressed: () async {
                              if (playing) {
                                // Pause playback
                                voiceChatHelper.pauseVoiceMessage();
                                VoiceChatHelper.currentlyPlayingMessageId.value = null;
                                setState(() {});
                              } else {
                                try {
                                  // Show loading indicator
                                  isLoading.value = true;

                                  // Extract audio URL
                                  String audioUrl = "";

                                  // Check media field first (new standard)
                                  if (widget.message.media != null && widget.message.media!.isNotEmpty) {
                                    audioUrl = widget.message.media!;
                                  }
                                  // Then check message field (old format)
                                  else if (widget.message.message != null &&
                                          widget.message.message.toString().startsWith('http')) {
                                    audioUrl = widget.message.message!;
                                  }

                                  if (audioUrl.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(AppHelpers.getTranslation(TrKeys.audioFileNotFound)),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                    isLoading.value = false;
                                    return;
                                  }

                                  // Play the voice message
                                  voiceChatHelper.playVoiceMessage(
                                    messageId: messageId,
                                    audioUrl: audioUrl,
                                  );

                                  // Update UI
                                  VoiceChatHelper.currentlyPlayingMessageId.value = messageId;
                                  isLoading.value = false;
                                  setState(() {});

                                  // Cancel any existing subscriptions
                                  _streamSubscriptions[messageId]?.cancel();

                                  // Listen for playback position updates
                                  _streamSubscriptions[messageId] = voiceChatHelper.playbackPositionStream.listen((position) {
                                    if (mounted && _positionNotifiers.containsKey(messageId)) {
                                      currentPosition.value = position.inSeconds;
                                    }
                                  });

                                  // Listen for playback completion - WhatsApp style auto-reset
                                  _streamSubscriptions['${messageId}_completion'] = voiceChatHelper.playbackStateStream.listen((state) {
                                    if (state.processingState == just_audio.ProcessingState.completed) {
                                      debugPrint("🎵 Playback completed for message: $messageId - Auto-resetting to play button");

                                      // Reset UI state - WhatsApp style
                                      VoiceChatHelper.currentlyPlayingMessageId.value = null;
                                      currentPosition.value = 0; // Reset waveform to beginning
                                      isLoading.value = false;

                                      if (mounted) {
                                        setState(() {});
                                      }

                                      // Cancel subscriptions for this message
                                      _streamSubscriptions[messageId]?.cancel();
                                      _streamSubscriptions['${messageId}_completion']?.cancel();
                                    }
                                  });
                                } catch (e) {
                                  isLoading.value = false;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(AppHelpers.getTranslation(TrKeys.errorPlayingVoiceMessage))),
                                  );
                                }
                              }
                            },
                            iconSize: 20.r,
                            padding: EdgeInsets.all(2.r),
                            constraints: BoxConstraints(
                              minWidth: 24.r,
                              minHeight: 24.r,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                SizedBox(width: 4.w),

                // Waveform visualization - Use Flexible to prevent overflow
                Flexible(
                  flex: 3,
                  child: ValueListenableBuilder<int>(
                    valueListenable: currentPosition,
                    builder: (context, position, _) {
                      return ValueListenableBuilder<String?>(
                        valueListenable: VoiceChatHelper.currentlyPlayingMessageId,
                        builder: (context, currentlyPlayingId, _) {
                          final playing = currentlyPlayingId == messageId;

                          // For debugging
                          if (playing && position > 0) {
                            debugPrint('Waveform update - Message: $messageId, Playing: $playing, Position: $position, Duration: $durationSeconds');
                          }

                          // Make sure we have a valid duration to avoid division by zero
                          // Use the same validated duration that was set earlier
                          final effectiveDuration = durationSeconds > 0 ? durationSeconds : 1;

                          return AudioWaveform(
                            durationSeconds: effectiveDuration,
                            color: owner ? widget.colors.white : widget.colors.textBlack,
                            isPlaying: playing,
                            currentPosition: position,
                          );
                        },
                      );
                    },
                  ),
                ),

                SizedBox(width: 4.w),

                // Duration and time in a column to save horizontal space
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Duration text
                    Text(
                      voiceChatHelper.formatDuration(durationSeconds),
                      style: CustomStyle.interNormal(
                        color: owner ? widget.colors.white : widget.colors.textBlack,
                        size: 10.sp, // Smaller font to save space
                      ),
                    ),
                    SizedBox(height: 2.h),
                    // Time indicator
                    _time(owner),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
