import 'dart:io';

import 'package:fire_chat/core/api/api.dart';
import 'package:fire_chat/core/models/models.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat/stream_chat.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' hide Message;
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:uuid/uuid.dart';


class StreamMessageApi {
  static Future<Message> getMessage(
      BuildContext context, {
    @required String id,
  }) async {
    final response = await StreamApi.client.getMessage(id);

    return response.message;
  }

  static Future<List<MessageModel>> getMessages() async {

 /*   final response = await StreamApi.client.getMessage(

    );

    final defaultImage =
        'https://images.unsplash.com/photo-1580907114587-148483e7bd5f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

    final allMessages = response.message.
        .map((msg) => MessageModel(
      id: msg.message.id,
      extraData: msg.message.extraData['image'] ?? defaultImage,
      type: msg.message.type,
      createdAt: msg.message.createdAt,
      text: msg.message.text,
      attachments: msg.message.attachments,
      latestReactions: msg.message.latestReactions,
      status: msg.message.status,
      showInChannel: msg.message.showInChannel,
      ownReactions: msg.message.ownReactions,
      updatedAt: msg.message.updatedAt,
    ))
        .toList();

    return allMessages;*/
  }

  static Future<MessageModel> createMessage(
      BuildContext context, {
        @required String id,
        @required String text,
        @required String attachments,
        @required String mentionedUsers,
        @required File imageFile,
        @required UserModel userModel,
        List<StreamChatClient> idClients = const [],
        bool waitForConect = true,
      }) async {
    final id = Uuid().v4();
    final urlImage =
    await FirebaseApi.uploadImage('images/$id', imageFile);

    final message = MessageModel(
      text: text,
      attachments: [
        Attachment(
            type: "image",
            assetUrl: urlImage,
            thumbUrl: urlImage,
            extraData: {
              "myCustomField": 123,
            }
        ),
      ],
      mentionedUsers: [
        UserModel(uid:id)
      ],
      extraData: {
        "anotherCustomField": 234,
      },
      id: id,
      user: UserModel(uid:id),
    );

    return message;
  }

}