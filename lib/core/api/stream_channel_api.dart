

import 'package:fire_chat/core/api/api.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as sc;
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:uuid/uuid.dart';

class StreamChannelApi {
  static Future<Channel> createChannel(
      BuildContext context, {
        @required String name,
        List<String> idMembers = const [],
      }) async {
    final idChannel = Uuid().v4();

    return createChannelWithUsers(
      context,
      name: name,
      idMembers: idMembers,
      idChannel: idChannel,
    );
  }

  static Future<Channel> createChannelWithUsers(
      BuildContext context, {
        @required String name,
        List<String> idMembers = const [],
        String idChannel,
      }) async {
    final id = idChannel ?? Uuid().v4();

    final idSelfUser = sc.StreamChat.of(context).user.id;
    final channel = StreamApi.client.channel(
      'messaging',
      id: id,
      extraData: {
        'name': name,
        'members': idMembers..add(idSelfUser),
      },
    );

    await channel.create();

    await channel.watch();
    return channel;
  }
}