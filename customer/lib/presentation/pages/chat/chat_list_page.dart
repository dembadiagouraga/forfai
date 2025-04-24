import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quick/application/chat/chat_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:lottie/lottie.dart';

import 'widget/chat_item.dart';
import 'widget/chat_shimmer.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  late RefreshController refreshController;

  @override
  void initState() {
    refreshController = RefreshController();
    super.initState();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final event = context.read<ChatBloc>();
    return CustomScaffold(
      body: (colors) => Column(
        children: [
          12.verticalSpace,
          Row(
            children: [
              8.horizontalSpace,
              Text(
                AppHelpers.getTranslation(TrKeys.chats),
                style: CustomStyle.interSemi(color: colors.textBlack, size: 18),
              ),
            ],
          ),
          16.verticalSpace,
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                return state.isLoading
                    ? ChatShimmer(colors: colors)
                    : state.chatList.isNotEmpty
                        ? SmartRefresher(
                            enablePullUp: true,
                            enablePullDown: true,
                            controller: refreshController,
                            onRefresh: () {
                              event.add(ChatEvent.getChatList(
                                context: context,
                                isRefresh: true,
                                controller: refreshController,
                              ));
                            },
                            onLoading: () {
                              event.add(ChatEvent.getChatList(
                                context: context,
                                controller: refreshController,
                              ));
                            },
                            child: ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 16.r),
                                shrinkWrap: true,
                                itemCount: state.chatList.length,
                                itemBuilder: (context, index) {
                                  return ButtonEffectAnimation(
                                    onTap: () async {
                                      await AppRoute.goChat(
                                          context: context,
                                          sender: state.chatList[index].user,
                                          chatId: state.chatList[index].docId ??
                                              "");
                                      if (context.mounted) {
                                        event.add(ChatEvent.getChatList(
                                          context: context,
                                          isRefresh: true,
                                          controller: refreshController,
                                        ));
                                      }
                                    },
                                    child: ChatItem(
                                      colors: colors,
                                      chat: state.chatList[index],
                                    ),
                                  );
                                }),
                          )
                        : _empty(context, colors);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _empty(BuildContext context, CustomColorSet colors) {
    return Column(
      children: [
        32.verticalSpace,
        Lottie.asset("assets/lottie/notification_empty.json",
            width: MediaQuery.sizeOf(context).width / 1.5),
        32.verticalSpace,
        Text(
          AppHelpers.getTranslation(TrKeys.yourChatListIsEmpty),
          style: CustomStyle.interSemi(color: colors.textBlack, size: 18),
        )
      ],
    );
  }
}
