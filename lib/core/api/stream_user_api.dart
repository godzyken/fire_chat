import 'package:fire_chat/core/api/api.dart';
import 'package:fire_chat/core/models/models.dart';
import 'package:fire_chat/ui/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class StreamUserApi {
  static Future<List<UserModel>> getAllUser({bool includeMe = false}) async {
    final sort = SortOption('last_message_at');
    final response = await StreamApi.client.queryUsers(sort: [sort]);

    final defaultImage = LogoGraphicHeader();

    final allUsers = response.users
        .map((user) => UserModel(
              name: user.name,
              photoUrl: user.extraData['image'] ?? defaultImage,
              isOnline: user.online,
              uid: user.id,
            ))
        .toList();

    return allUsers;
  }

  static Future createUser({
    @required String uid,
    @required String username,
    @required String urlImage,
  }) async {
    final token = StreamApi.client.devToken(uid);

    final user = User(
      id: uid,
      extraData: {
        'name': username,
        'image': urlImage,
      },
    );
    await StreamApi.client.connectUser(user, token);
  }

  static Future login({@required String uid}) async {
    final token = StreamApi.client.devToken(uid);

    final user = User(id: uid);
    await StreamApi.client.connectUser(user, token);
  }
}
