import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/components/media/video_page.dart';
import 'package:quick/presentation/style/style.dart';

class CustomNetworkImage extends StatelessWidget {
  // Helper method to check if URL is a video
  bool _isVideoUrl(String? url) {
    if (url == null || url.isEmpty) return false;

    for (final ext in AppConstants.videoTypes) {
      if (url.toLowerCase().endsWith(ext.toString())) {
        return true;
      }
    }
    return false;
  }

  // Helper method to format URLs
  String _getFormattedUrl(String? inputUrl) {
    if (inputUrl == null || inputUrl.isEmpty) {
      return "";
    }

    String fixedUrl = inputUrl;

    // Fix host issues - replace 127.0.0.1 with the correct IP
    if (fixedUrl.contains('127.0.0.1')) {
      fixedUrl = fixedUrl.replaceAll('127.0.0.1', '192.168.0.107');
    }

    // Fix double storage path issue
    if (fixedUrl.contains('/storage/storage/')) {
      fixedUrl = fixedUrl.replaceAll('/storage/storage/', '/storage/');
    }

    // Fix double slash issue
    if (fixedUrl.contains('//storage/')) {
      fixedUrl = fixedUrl.replaceAll('//storage/', '/storage/');
    }

    if (fixedUrl.startsWith('http')) {
      return fixedUrl;
    }

    // Fix double storage issue
    String pathToUse = inputUrl;

    // Remove leading slash if present
    if (pathToUse.startsWith('/')) {
      pathToUse = pathToUse.substring(1);
    }

    // Fix double storage path issue
    if (pathToUse.startsWith('storage/')) {
      pathToUse = pathToUse.replaceFirst('storage/', '');
    }

    return "${AppConstants.imageUrl}$pathToUse";
  }
  final String? url;
  final File? fileImage;
  final String? preview;
  final String? name;
  final double height;
  final double width;
  final double radius;
  final double? topRadius;
  final BoxFit fit;
  final bool enableButton;
  final VoidCallback? onDelete;

  const CustomNetworkImage({
    super.key,
    required this.url,
    required this.height,
    required this.width,
    this.radius = AppConstants.radius,
    this.fit = BoxFit.cover,
    this.name,
    this.preview,
    this.fileImage,
    this.enableButton = true,
    this.onDelete,
    this.topRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: topRadius == null
          ? BorderRadius.circular(radius.r)
          : BorderRadius.vertical(top: Radius.circular(radius.r)),
      child: preview != null && _isVideoUrl(preview)
          ? Stack(
              children: [
                CachedNetworkImage(
                  height: height.r,
                  width: width.r,
                  imageUrl: _getFormattedUrl(preview),
                  fit: fit,
                  maxWidthDiskCache: 256,
                  maxHeightDiskCache: 256,
                  // memCacheWidth: 512,
                  memCacheHeight: 512,
                  progressIndicatorBuilder: (context, url, progress) {
                    return Container(
                      height: height.r,
                      width: width.r,
                      decoration: BoxDecoration(
                        color: CustomStyle.shimmerBase,
                      ),
                      child: width > 58
                          ? Center(
                              child: Text(
                                AppHelpers.getTranslation(
                                    AppHelpers.getAppName()),
                                style: CustomStyle.interNormal(
                                    color: CustomStyle.textHint),
                              ),
                            )
                          : const SizedBox.shrink(),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius.r),
                        color: name == null
                            ? CustomStyle.shimmerBase
                            : CustomStyle.primary,
                      ),
                      alignment: Alignment.center,
                      child: name == null
                          ? const Icon(Remix.file_unknow_line)
                          : Text(
                              name?.substring(0, 1) ?? "",
                              style: CustomStyle.interNormal(
                                  color: CustomStyle.white, size: height / 2.5),
                            ),
                    );
                  },
                ),
                if (enableButton && _isVideoUrl(url))
                  Positioned.fill(
                    child: Center(
                      child: ButtonEffectAnimation(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VideoPage(url: url)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: CustomStyle.icon),
                              shape: BoxShape.circle),
                          child: Container(
                            margin: EdgeInsets.all(2.r),
                            padding: EdgeInsets.all(16.r),
                            decoration: BoxDecoration(
                                color: CustomStyle.primary.withValues(alpha: 0.4),
                                shape: BoxShape.circle),
                            child: const Icon(
                              Remix.play_fill,
                              color: CustomStyle.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            )
          : fileImage != null
              ? Image.file(
                  fileImage!,
                  height: height,
                  width: width,
                  fit: fit,
                )
              : CachedNetworkImage(
                  height: height.r,
                  width: width.r,
                  imageUrl: _getFormattedUrl(url),
                  fit: fit,
                  progressIndicatorBuilder: (context, url, progress) {
                    return Container(
                      height: height.r,
                      width: width.r,
                      decoration: BoxDecoration(
                        color: CustomStyle.shimmerBase,
                      ),
                      child: width > 58
                          ? Center(
                              child: Text(
                                AppHelpers.getTranslation(
                                    AppHelpers.getAppName()),
                                style: CustomStyle.interNormal(
                                    color: CustomStyle.textHint),
                              ),
                            )
                          : const SizedBox.shrink(),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius.r),
                        color: name == null
                            ? CustomStyle.shimmerBase
                            : CustomStyle.primary,
                      ),
                      alignment: Alignment.center,
                      child: name == null
                          ? const Icon(Remix.file_unknow_line)
                          : Text(
                              name?.substring(0, 1) ?? "",
                              style: CustomStyle.interNormal(
                                  color: CustomStyle.white, size: height / 2.5),
                            ),
                    );
                  },
                ),
    );
  }
}
