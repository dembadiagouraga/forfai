import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class VoiceNotePlayer extends StatefulWidget {
  final CustomColorSet colors;
  final String? voiceNoteUrl;
  final int? voiceNoteDuration;

  const VoiceNotePlayer({
    super.key,
    required this.colors,
    required this.voiceNoteUrl,
    this.voiceNoteDuration,
  });

  @override
  State<VoiceNotePlayer> createState() => _VoiceNotePlayerState();
}

class _VoiceNotePlayerState extends State<VoiceNotePlayer> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    // Listen to player state changes
    _audioPlayer.playerStateStream.listen((state) {
      if (state.playing != _isPlaying) {
        setState(() {
          _isPlaying = state.playing;
        });
      }
    });

    // Listen to duration changes
    _audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        setState(() {
          _duration = duration;
        });
      }
    });

    // Listen to position changes
    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _position = position;
      });
    });

    // Load the audio file
    if (widget.voiceNoteUrl != null && widget.voiceNoteUrl!.isNotEmpty) {
      try {
        // Check if the URL is an AAC file and try to convert it to MP3
        String urlToPlay = widget.voiceNoteUrl!;
        if (urlToPlay.endsWith('.aac')) {
          urlToPlay = urlToPlay.replaceAll('.aac', '.mp3');
          debugPrint("Converting AAC URL to MP3: $urlToPlay");
        }

        try {
          // Try to load the MP3 URL first
          await _audioPlayer.setUrl(urlToPlay);
          debugPrint("Successfully loaded audio URL: $urlToPlay");
        } catch (e) {
          // If MP3 fails, try the original URL
          if (urlToPlay != widget.voiceNoteUrl) {
            debugPrint("MP3 URL failed, trying original URL: ${widget.voiceNoteUrl}");
            await _audioPlayer.setUrl(widget.voiceNoteUrl!);
          } else {
            // If original URL fails, rethrow
            rethrow;
          }
        }

        // If we have a duration from the server, use it
        if (widget.voiceNoteDuration != null && widget.voiceNoteDuration! > 0) {
          setState(() {
            _duration = Duration(seconds: widget.voiceNoteDuration!);
          });
        }

        // Set a maximum duration of 2 minutes (120 seconds)
        if (_duration.inSeconds > 120) {
          debugPrint('Voice note exceeds maximum duration of 2 minutes');
        }
      } catch (e) {
        debugPrint('Error loading audio file: $e');
      }
    }
  }

  // Play or pause voice note
  void _togglePlayVoiceNote() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
  }

  // Format duration
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.voiceNoteUrl == null || widget.voiceNoteUrl!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        12.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Text(
            AppHelpers.getTranslation(TrKeys.voiceNote),
            style: CustomStyle.interSemi(color: widget.colors.textBlack, size: 18),
          ),
        ),
        12.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF128C7E), // WhatsApp green color
              borderRadius: BorderRadius.circular(16.r),
            ),
            padding: EdgeInsets.all(12.r),
            child: Stack(
              children: [
                Row(
                  children: [
                    // Play/Pause button
                    InkWell(
                      onTap: _togglePlayVoiceNote,
                      child: Container(
                        width: 40.r,
                        height: 40.r,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: const Color(0xFF128C7E),
                          size: 24.r,
                        ),
                      ),
                    ),
                    12.horizontalSpace,
                    // Progress bar
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SliderTheme(
                            data: SliderThemeData(
                              trackHeight: 4.r,
                              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.r),
                              overlayShape: RoundSliderOverlayShape(overlayRadius: 14.r),
                              activeTrackColor: Colors.white.withValues(alpha: 0.7),
                              inactiveTrackColor: Colors.white.withValues(alpha: 0.3),
                              thumbColor: Colors.white,
                              overlayColor: Colors.white.withValues(alpha: 0.2),
                            ),
                            child: Slider(
                              value: _position.inMilliseconds.toDouble(),
                              max: _duration.inMilliseconds.toDouble(),
                              onChanged: (value) {
                                _audioPlayer.seek(Duration(milliseconds: value.toInt()));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Timer positioned at bottom right
                Positioned(
                  right: 8.r,
                  bottom: -2.r, /* Changed from 0 to -2 to move it down a bit */
                  child: Text(
                    _formatDuration(_position),
                    style: CustomStyle.interRegular(
                      color: Colors.white.withValues(alpha: 0.7),
                      size: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        8.verticalSpace,
        Divider(color: widget.colors.divider, thickness: 1.r),
      ],
    );
  }
}
