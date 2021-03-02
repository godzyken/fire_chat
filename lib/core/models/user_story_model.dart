import 'package:fire_chat/core/models/models.dart';
import 'package:flutter/cupertino.dart';

class UserStoryModel {

  final List<StoryModel> stories;
  final String userName;
  final String userImageUrl;

  const UserStoryModel({
    @required this.stories,
    @required this.userName,
    @required this.userImageUrl,
  });

  UserStoryModel copy({
    List<StoryModel> stories,
    String userName,
    String userImageUrl,
  }) =>
      UserStoryModel(
        stories: stories ?? this.stories,
        userName: userName ?? this.userName,
        userImageUrl: userImageUrl ?? this.userImageUrl,
      );

  static UserStoryModel fromJson(Map<String, dynamic> json) => UserStoryModel(
    stories: json['stories'],
    userName: json['userName'],
    userImageUrl: json['userImageUrl'],
  );

  Map<String, dynamic> toJson() => {
    'stories': stories,
    'userName': userName,
    'userImageUrl': userImageUrl,
  };
}