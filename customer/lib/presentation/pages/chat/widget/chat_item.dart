import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/domain/model/model/chat_model.dart';
import 'package:quick/infrastructure/service/time_service.dart';
import 'package:quick/presentation/components/media/custom_network_image.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class ChatItem extends StatelessWidget {
  final CustomColorSet colors;
  final ChatModel chat;

  const ChatItem({super.key, required this.colors, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.r),
      padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 16.r),
      decoration: BoxDecoration(
        color: colors.newBoxColor,
        borderRadius: BorderRadius.circular(AppConstants.radius.r),
      ),
      child: Row(
        children: [
          CustomNetworkImage(
            url: chat.user?.img,
            height: 56,
            width: 56,
            radius: 28,
            name: chat.user?.firstname ?? chat.user?.lastname,
          ),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${chat.user?.firstname ?? ""} ${chat.user?.lastname ?? ""}",
                  style: CustomStyle.interNormal(color: colors.textBlack),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                6.verticalSpace,
                Text(
                  chat.lastMessage ?? "",
                  style: CustomStyle.interRegular(
                      color: colors.textHint, size: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(
            TimeService.dateFormatForChat(chat.lastTime?.toDate()),
            style: CustomStyle.interRegular(color: colors.textHint, size: 14),
          ),
        ],
      ),
    );
  }
}
