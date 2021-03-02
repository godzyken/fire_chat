import 'dart:io';

import 'package:fire_chat/core/api/api.dart';
import 'package:fire_chat/core/models/models.dart';
import 'package:stream_chat/stream_chat.dart';
import 'package:uuid/uuid.dart';

class StreamStoryApi {
  static Future addStory(StoryModel story, File imageFile) async {
    final user = StreamApi.client.state.user;
    final userJson = user.toJson();

    // Upload image
    final idStory = Uuid().v4();
    final urlImage = await FirebaseApi.uploadImage(
        'user/${user.id}/stories/$idStory', imageFile);
    final newStory = story.copy(imageUrl: urlImage);

    // Add new stories
    final currentStories = userJson['stories'] ?? [];
    final stories = currentStories..add(newStory.toJson());

    final newUserJson = userJson..addAll({'stories': stories});
    final newUser = User.fromJson(newUserJson);

    await StreamApi.client.updateUser(newUser);
  }

  static Future<List<UserStoryModel>> getStories() async {
    final sort = SortOption('last_message_at');
    final response = await StreamApi.client.queryUsers(sort: [sort]);

    final allStories = response.users
        .where((user) => user.extraData['stories'] != null)
        .map<UserStoryModel>((user) {
      final storiesJson = user.extraData['stories'];

      final stories =
      storiesJson.map<StoryModel>((json) => StoryModel.fromJson(json)).toList();

      return UserStoryModel(
        stories: stories,
        userName: user.name,
        userImageUrl: user.extraData['image'],
      );
    }).toList();

    return allStories;
  }
}