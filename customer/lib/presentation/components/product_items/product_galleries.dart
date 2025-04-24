import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/domain/model/models.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../media/custom_network_image.dart';

class ProductGalleries extends StatelessWidget {
  // Helper method to fix double storage path issue
  String? _fixImagePath(String? inputUrl) {
    if (inputUrl == null || inputUrl.isEmpty) {
      return "";
    }

    String fixedUrl = inputUrl;

    if (fixedUrl.startsWith('http')) {
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

      return fixedUrl;
    }

    // Fix double storage path issue
    String pathToUse = fixedUrl;

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
  final double height;
  final double width;
  final String? img;
  final List<Galleries> galleries;

  const ProductGalleries({
    super.key,
    required this.galleries,
    required this.height,
    required this.width,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    if (galleries.length < 2) {
      return CustomNetworkImage(
        url: galleries.isNotEmpty ? _fixImagePath(galleries.first.path) : _fixImagePath(img),
        preview: galleries.isNotEmpty ? _fixImagePath(galleries.first.preview) : null,
        height: height,
        width: double.infinity,
        topRadius: AppConstants.radius,
      );
    } else {
      return _MultiImages(height, width, galleries);
    }
  }
}

class _MultiImages extends StatefulWidget {
  final double height;
  final double width;
  final List<Galleries> galleries;

  const _MultiImages(this.height, this.width, this.galleries);

  @override
  State<_MultiImages> createState() => _MultiImagesState();
}

class _MultiImagesState extends State<_MultiImages> {
  // Helper method to fix double storage path issue
  String? _fixImagePath(String? inputUrl) {
    if (inputUrl == null || inputUrl.isEmpty) {
      return "";
    }

    String fixedUrl = inputUrl;

    if (fixedUrl.startsWith('http')) {
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

      return fixedUrl;
    }

    // Fix double storage path issue
    String pathToUse = fixedUrl;

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
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Stack(
      children: [
        SizedBox(
          height: widget.height.r,
          width: widget.width,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppConstants.radius.r),
            ),
            child: PageView.builder(
                itemCount: widget.galleries.length,
                scrollDirection: Axis.horizontal,
                controller: pageController,
                itemBuilder: (context, index) {
                  return CustomNetworkImage(
                    url: _fixImagePath(widget.galleries[index].path),
                    preview: _fixImagePath(widget.galleries[index].preview),
                    height: widget.height,
                    width: double.infinity,
                    topRadius: AppConstants.radius,
                  );
                }),
          ),
        ),
        Positioned(
          bottom: 4.r,
          left: 0,
          right: 0,
          child: Container(
              height: 4.r,
              width: widget.width.r,
              alignment: Alignment.bottomCenter,
              child: SmoothPageIndicator(
                  controller: pageController,
                  count: widget.galleries.length,
                  effect: ScrollingDotsEffect(
                      dotWidth: 20.r,
                      strokeWidth: 12.r,
                      spacing: 6.r,
                      activeDotScale: 1,
                      radius: 2.r,
                      dotHeight: 3.r,
                      activeDotColor: CustomStyle.black,
                      paintStyle: PaintingStyle.fill),
                  onDotClicked: (index) {})),
        )
      ],
    );
  }
}
