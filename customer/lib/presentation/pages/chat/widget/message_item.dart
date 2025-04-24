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
import 'package:just_audio/just_audio.dart';
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

  @override
  void dispose() {
    // Clean up all position notifiers
    for (final notifier in _positionNotifiers.values) {
      notifier.dispose();
    }
    _positionNotifiers.clear();

    // Cancel all stream subscriptions
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

    // Get the duration in seconds
    final durationSeconds = int.tryParse(widget.message.audioDuration ?? "0") ?? 0;

    // Message ID already defined above

    // Get or create a position notifier for this message
    final messageId = widget.message.doc ?? "";
    if (!_positionNotifiers.containsKey(messageId)) {
      _positionNotifiers[messageId] = ValueNotifier<int>(0);
    }
    final currentPosition = _positionNotifiers[messageId]!;

    // We don't need to add a listener here as we're using ValueListenableBuilder

    // Debug info
    debugPrint('Rendering voice message: owner=$owner, duration=$durationSeconds, path=${widget.message.media}, senderId=${widget.message.senderId}, userId=${LocalStorage.getUser().id}');

    return Container(
      width: MediaQuery.sizeOf(context).width * 2 / 3, // Match text message width
      margin: EdgeInsets.only(bottom: 8.r, left: owner ? 0 : 8.r, right: owner ? 8.r : 0), // Align to correct side
      padding: EdgeInsets.symmetric(vertical: 14.r, horizontal: 12.r), // Increased vertical padding for voice messages
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
            children: [
              // Play button with animation
              // Use global state to determine if this message is playing
              ValueListenableBuilder<String?>(
                valueListenable: VoiceChatHelper.currentlyPlayingMessageId,
                builder: (context, currentlyPlayingId, child) {
                  final playing = currentlyPlayingId == messageId;
                  return IconButton(
                    icon: Icon(playing ? Icons.pause : Icons.play_arrow),
                    onPressed: () {
                      if (playing) {
                        debugPrint("Pausing voice message: $messageId");

                        // First pause the audio
                        voiceChatHelper.pauseVoiceMessage();

                        // Then update UI
                        VoiceChatHelper.currentlyPlayingMessageId.value = null;
                        setState(() {});
                      } else {
                        try {
                          debugPrint("Playing voice message: $messageId");

                          // First play the audio
                          voiceChatHelper.playVoiceMessage(
                            messageId: messageId,
                            audioUrl: widget.message.media ?? "",
                          );

                          // Then update UI
                          VoiceChatHelper.currentlyPlayingMessageId.value = messageId;
                          setState(() {});

                          // Cancel any existing subscription
                          _streamSubscriptions[messageId]?.cancel();

                          // Listen for playback position updates
                          _streamSubscriptions[messageId] = voiceChatHelper.playbackPositionStream.listen((position) {
                            if (mounted && _positionNotifiers.containsKey(messageId)) {
                              currentPosition.value = position.inSeconds;

                              // Also check player state to ensure UI is consistent
                              final playerState = voiceChatHelper.getCurrentPlayerState();
                              if (playerState == AudioPlayerState.playing &&
                                  VoiceChatHelper.currentlyPlayingMessageId.value != messageId) {
                                // If playing but UI shows play button, update UI
                                VoiceChatHelper.currentlyPlayingMessageId.value = messageId;
                                setState(() {});
                              } else if (playerState != AudioPlayerState.playing &&
                                       VoiceChatHelper.currentlyPlayingMessageId.value == messageId) {
                                // If not playing but UI shows pause button, update UI
                                VoiceChatHelper.currentlyPlayingMessageId.value = null;
                                setState(() {});
                              }
                            }
                          });

                          // Playback completion is handled by VoiceChatHelper
                        } catch (e) {
                          debugPrint("Error playing: $e");
                          // Show error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(AppHelpers.getTranslation(TrKeys.errorPlayingVoiceMessage))),
                          );
                        }
                      }
                    },
                    color: owner ? widget.colors.white : widget.colors.textBlack,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    iconSize: 30.r, // Increased icon size
                  );
                },
              ),

              const SizedBox(width: 8),

              // Waveform visualization
              Expanded(
                child: ValueListenableBuilder<int>(
                  valueListenable: currentPosition,
                  builder: (context, position, child) {
                    return ValueListenableBuilder<String?>(
                      valueListenable: VoiceChatHelper.currentlyPlayingMessageId,
                      builder: (context, currentlyPlayingId, child) {
                        // Check if this message is currently playing
                        final playing = currentlyPlayingId == messageId;

                        // For debugging
                        if (messageId == widget.message.doc) {
                          debugPrint("Waveform update - Message: $messageId, Playing: $playing, Position: $position");
                        }

                        return AudioWaveform(
                          durationSeconds: durationSeconds,
                          color: owner ? widget.colors.white : widget.colors.textBlack,
                          isPlaying: playing,
                          currentPosition: position,
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(width: 8),

              // Duration text
              Text(
                voiceChatHelper.formatDuration(durationSeconds),
                style: CustomStyle.interNormal(
                  color: owner ? widget.colors.white : widget.colors.textBlack,
                  size: 12.sp,
                ),
              ),

              const SizedBox(width: 4),

              // Time with extra padding for voice messages
              Container(
                padding: EdgeInsets.only(top: 20.r), // Add extra padding at the top
                child: _time(owner),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
