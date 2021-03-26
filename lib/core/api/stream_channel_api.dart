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

    final sort = [
      SortOption<ChannelModel>('last_message_at', direction: SortOption.DESC)
    ];

    final channels = StreamApi.client.queryChannels(
      filter: filter,
      sort: sort,
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
    StreamChatClient idClient,
    String idChannel,
    List<Message> idMessages = const [],
    Message idMessage,
    String type,
    List<StreamChatClient> idClients = const [],
  }) async {
    try {
      final id = idChannel ?? Uuid().v4();

      final channelType = StreamChannel.of(context).channel.type;
      final messages = StreamChannel.of(context).getMessage(idChannel);
      final idSelfUser = StreamChat.of(context).user.id;
      final idMessagesSend = StreamChat.of(context)
          .user
          .extraData[messages]
          .client
          .sendMessage(idMessage, idChannel, channelType);
      final idClient = StreamChatClient(StreamApi.apiKey);

      final channel = StreamApi.client.channel(
        channelType,
        id: id,
        extraData: {
          'name': name,
          'image': urlImage,
          'members': idMembers..add(idSelfUser),
          'messages': idMessages..add(idMessagesSend),
          'clients': idClients..add(idClient),
        },
      );

      await channel.create();

      await channel.watch();
      return channel;
    } catch (e) {
      print('wOAAAAAAApen : $e');
    }
    return null;
  }

  static Future<Channel> getOrCreateUsers(
    BuildContext context, {
    @required String idChannel,
    @required Channel idCurrentChannel,
  }) async {
    bool isLogging = false;
    final isCurrentChannel = StreamChannel.of(context).channel.cid;
    if (isCurrentChannel == null) {
      isLogging = true;
      final createOne = await createChannel(context,
          name: idChannel,
          imageFile: idCurrentChannel.extraData['image'],
      );
      isLogging = false;
      return createOne;
    } else {
      isLogging = false;
      throw ErrorWidget.builder;
    }
  }

  static Future<Channel> watchChannel(
    StreamChatClient client, {
    @required String type,
    @required String id,
  }) async {
    final channel = client.channel(type, id: id);

    channel.watch();
    return channel;
  }
}
