import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/profile/profile_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class AvatarEditScreen extends StatelessWidget {
  final CustomColorSet colors;

  const AvatarEditScreen({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return ButtonEffectAnimation(
      onTap: () {
        AppHelpers.openDialogImagePicker(
          context: context,
          openCamera: () async {
            String? titleImg = await ImgService.getCamera();
            if (context.mounted && (titleImg != null)) {
              context
                  .read<ProfileBloc>()
                  .add(ProfileEvent.updateImagePath(imagePath: titleImg));
              Navigator.pop(context);
            }
          },
          openGallery: () async {
            String? titleImg = await ImgService.getGallery();
            if (context.mounted && (titleImg != null)) {
              context
                  .read<ProfileBloc>()
                  .add(ProfileEvent.updateImagePath(imagePath: titleImg));
              Navigator.pop(context);
            }
          },
        );
      },
      child: Stack(
        children: [
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return Padding(
                padding: REdgeInsets.only(right: 8, bottom: 8),
                child: state.imagePath == null
                    ? CustomNetworkImage(
                        url: LocalStorage.getUser().img,
                        name: LocalStorage.getUser().firstname ??
                            LocalStorage.getUser().lastname,
                        height: 84.r,
                        width: 84.r,
                        radius: (AppConstants.radius/0.6).r)
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(42.r),
                            border: Border.all(color: colors.textHint)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(42.r),
                          child: Image.file(
                            File(state.imagePath ?? ""),
                            width: 84.r,
                            height: 84.r,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              );
            },
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.backgroundColor,
                    border: Border.all(
                      color: colors.border,
                      width: 2,
                    )),
                child: Icon(
                  Remix.pencil_line,
                  color: colors.textBlack,
                )),
          ),
        ],
      ),
    );
  }
}
