import 'package:fire_chat/core/models/models.dart';
import 'package:fire_chat/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class StoryViewPage extends StatefulWidget {
  final List<UserStoryModel> stories;
  final UserStoryModel userStory;

  const StoryViewPage({
    Key key,
    @required this.stories,
    @required this.userStory,
  }) : super(key: key);


  @override
  _StoryViewPageState createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  PageController pageController;

  @override
  void initState() {
    super.initState();

    final index = widget.stories.indexOf(widget.userStory);
    pageController = PageController(initialPage: index);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PageView(
    controller: pageController,
    children: widget.stories
        .map((user) => StoryDelegateWidget(
      userStory: user,
      allStories: widget.stories,
      pageController: pageController,
    ))
        .toList(),
  );
}
