import 'dart:io';

import 'package:fire_chat/core/api/api.dart';
import 'package:fire_chat/core/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:uuid/uuid.dart';

class StreamChannelApi {
  static Future<List<Channel>> searchChannel({
    @required String idUser,
    @required String username,
  }) async {
    final idSelfUser = AuthController.to.getUser;
    final filter = {
      'name': '$username',
      "members": {
        "\$in": [idUser, idSelfUser],
      }
    };
    final channels = await StreamApi.client.queryChannels(filter: filter);

    return channels.isEmpty != null ? null : channels.first;
  }

  static Future<Channel> createChannel(
      BuildContext context, {
        @required String name,
        @required File imageFile,
        List<String> idMembers = const [],
      }) async {
    final idChannel = Uuid().v4();

    final urlImage = await FirebaseApi.uploadImage('images/$idChannel', imageFile);

    return createChannelWithUsers(
      context,
      name: name,
      urlImage: urlImage,
      idMembers: idMembers,
      idChannel: idChannel,
    );
  }

  static Future<Channel> createChannelWithUsers(
      BuildContext context, {
        @required String name,
        @required String urlImage,
        List<String> idMembers = const [],
        String idChannel,
      }) async {
    final id = idChannel ?? Uuid().v4();

    final idSelfUser = StreamChat.of(context).user.id;
    final channel = StreamApi.client.channel(
      'messaging',
      id: id,
      extraData: {
        'name': name,
        'image': urlImage,
        'members': idMembers..add(idSelfUser),
      },
    );

    await channel.create();

    await channel.watch();
    return channel;
  }
}