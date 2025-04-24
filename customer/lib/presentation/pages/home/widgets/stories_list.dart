import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quick/application/story/story_bloc.dart';
import 'package:quick/presentation/components/shimmer/stories_shimmer.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/theme/theme.dart';

import 'story_item.dart';

class StoriesList extends StatelessWidget {
  final CustomColorSet colors;
  final RefreshController storyRefresh;

  const StoriesList(
      {super.key, required this.colors, required this.storyRefresh});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryBloc, StoryState>(
      builder: (context, state) {
        return state.isLoadingBanner
            ? const StoriesShimmer()
            : state.story.isNotEmpty
                ? SizedBox(
                    height: 104.r,
                    child: SmartRefresher(
                      enablePullDown: false,
                      enablePullUp: true,
                      controller: storyRefresh,
                      scrollDirection: Axis.horizontal,
                      onLoading: () {
                        context.read<StoryBloc>().add(StoryEvent.fetchStory(
                            context: context, controller: storyRefresh));
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                padding: REdgeInsets.symmetric(horizontal: 16),
                                scrollDirection: Axis.horizontal,
                                itemCount: state.story.isNotEmpty
                                    ? state.story.first?.length
                                    : 0,
                                itemBuilder: (context, index) {
                                  return StoryItem(
                                    colors: colors,
                                    story: (state.story.first?[index]),
                                    onTap: () {
                                      AppRoute.goStoryPagePage(
                                          context: context,
                                          controller: storyRefresh,
                                          index: index);
                                    },
                                  );
                                }),
                          ),
                          Divider(color: colors.divider),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink();
      },
    );
  }
}
