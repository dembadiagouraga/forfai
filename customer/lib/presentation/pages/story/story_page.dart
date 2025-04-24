import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick/application/story/story_bloc.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widgets/story_image.dart';

class StoryPage extends StatefulWidget {
  final RefreshController controller;
  final int index;

  const StoryPage({super.key, required this.controller, required this.index});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  late PageController? pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: widget.index);
    super.initState();
  }

  @override
  void dispose() {
    pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomStyle.bgDark,
      body: BlocBuilder<StoryBloc, StoryState>(
        builder: (context, state) {
          return PageView.builder(
            controller: pageController,
            itemCount: state.story.isNotEmpty ? state.story.first?.length : 0,
            physics: const PageScrollPhysics(),
            itemBuilder: (context, index) {
              return StoryImage(
                story: [state.story.first![index]],
                nextPage: () {
                  if (index == (state.story.first?.length ?? 0) - 2) {
                    context.read<StoryBloc>().add(StoryEvent.fetchStory(
                        context: context, controller: widget.controller));
                  }
                  if (index != (state.story.first?.length ?? 0) - 1) {
                    pageController!.animateToPage(++index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  } else {
                    Navigator.pop(context);
                  }
                },
                prevPage: () {
                  if (index != 0) {
                    pageController!.animateToPage(--index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  } else {
                    Navigator.pop(context);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
