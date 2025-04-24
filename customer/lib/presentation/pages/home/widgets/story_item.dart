import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/domain/model/model/story_model.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class StoryItem extends StatelessWidget {
  final CustomColorSet colors;
  final StoryModel? story;
  final VoidCallback onTap;

  const StoryItem({
    super.key,
    required this.colors,
    required this.story,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonEffectAnimation(
      onTap: onTap,
      child: Padding(
        padding: REdgeInsets.only(right: 8.r),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(2.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: colors.primary, width: 1.8),
              ),
              child: CustomNetworkImage(
                url: story?.url,
                height: 56,
                width: 56,
                radius: 30,
              ),
            ),
            4.verticalSpace,
            SizedBox(
              width: 64.r,
              child: Text(
                story?.title ?? '',
                style:
                    CustomStyle.interNormal(color: colors.textBlack, size: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
