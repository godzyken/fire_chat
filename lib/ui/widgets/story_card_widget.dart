
import 'package:fire_chat/core/models/models.dart';
import 'package:fire_chat/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddStoryCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StoryCardWidget(
    title: '',
    urlImage: '',
    onClicked: () {},
  );
}

class UserStoryCardWidget extends StatelessWidget {
  final UserStoryModel story;

  const UserStoryCardWidget({
    Key key,
    @required this.story,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => StoryCardWidget(
    title: story.userName,
    urlImage: story.stories.first.imageUrl,
    urlAvatar: story.userImageUrl,
    onClicked: () {
      if (story.stories.isEmpty) return;

      GetBuilder(
        builder: (context) => StoryViewPage(
          stories: [story],
          userStory: story,
        ),
      );
    },
  );
}

class StoryCardWidget extends StatelessWidget {
  final String title;
  final String urlImage;
  final String urlAvatar;
  final VoidCallback onClicked;

  const StoryCardWidget({
    Key key,
    @required this.title,
    @required this.urlImage,
    @required this.onClicked,
    this.urlAvatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: buildAdd(),
      ),
    );
  }

  Widget buildAdd() => Center(
    child: Icon(Icons.add, size: 72, color: Colors.white),
  );
}