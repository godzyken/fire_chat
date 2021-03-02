import 'dart:convert';

import 'package:fire_chat/core/api/api.dart';
import 'package:fire_chat/core/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:foundation/model/user_token.dart';
import 'package:foundation/request/authentication_request.dart';
import 'package:foundation/request/authentication_response.dart';
import 'package:http/http.dart' as http;

class StreamUserApi {
  static Future<List<UserModel>> getAllUsers({bool includeMe = false}) async {
    final sort = SortOption('last_message_at');
    final filter = {
      "id": {"\$autocomplete": "USER_ID"},
    };
    final response = await StreamApi.client.queryUsers(
      filter: filter,
      sort: [sort],
      pagination: PaginationParams(
        offset: 0,
        limit: 20,
      ),
    );

    final defaultImage =
        'https://images.unsplash.com/photo-1580907114587-148483e7bd5f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

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
    final userToken = await _generateUserToken(idUser: uid);

    final user = User(
      id: uid,
      extraData: {
        'name': username,
        'image': urlImage,
      },
    );
    await StreamApi.client.connectUser(user, userToken.token);
  }

  static Future login({@required String uid}) async {
    final userToken = await _generateUserToken(idUser: uid);

    final user = User(id: uid);
    await StreamApi.client.connectUser(user, userToken.token);
  }

  static Future loggOutOrSwitchUser({
    @required String uid,
    @required String username,
  }) async {
    await StreamApi.client.disconnect(
      clearUser: true,
      flushChatPersistence: true,
    );

    final otherUser = User(id: uid, extraData: {
      "name": username,
    });

    final otherToken = await _generateUserToken(idUser: otherUser.id);

    await StreamApi.client.connectUser(
      otherUser,
      otherToken.token,
    );
  }

  static Future<UserToken> _generateUserToken({
    @required String idUser,
  }) async {
    const urlAuthentication = 'http://localhost:5000/stream-chat-d5827-306316/us-central1/createToken';
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    final request = AuthenticationRequest(idUser: idUser);
    final json = jsonEncode(request.toJson());

    final response =
        await http.post(urlAuthentication, headers: headers, body: json);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final reviewResponse = AuthenticationResponse.fromJson(data);

      if (reviewResponse.error.isNotEmpty) {
        throw UnimplementedError(
            'Error: generateToken ${reviewResponse.error}');
      } else {
        return reviewResponse.userToken;
      }
    } else {
      throw UnimplementedError('Error: generateToken');
    }
  }
}
