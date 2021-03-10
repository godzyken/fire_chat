import 'dart:io';

import 'package:fire_chat/core/api/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat/stream_chat.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' hide Channel;
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:meta/meta.dart';

class StreamChannelApi {
  static Future<List<Channel>> searchChannel({
    @required String idUser,
    @required String username,
  }) async {
    final idSelfUser = FirebaseAuth.instance.currentUser;
    final filter = {
      'type': 'messaging',
      "members": {
        "\$in": [idUser, idSelfUser.uid],
      }
    };

    final sort = [SortOption('last_message_at', direction: SortOption.DESC)];

    final channels = StreamApi.client.queryChannels(
      filter: filter,
      sort: sort,
      preferOffline: true,
      messageLimit: 20,
      waitForConnect: true,
      paginationParams: PaginationParams(limit: 10),
      options: {
        "watch": true,
        "state": true,
      },
    );

    return channels.isEmpty != null ? null : channels.first;
  }

  static Future<Channel> createChannel(
    BuildContext context, {
    @required String name,
    @required File imageFile,
    List<String> idMembers = const [],
    bool waitForConect = true,
  }) async {
    final idChannel = Uuid().v4();

    final urlImage =
        await FirebaseApi.uploadImage('images/$idChannel', imageFile);

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
