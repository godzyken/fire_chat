import 'package:flutter/foundation.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class StreamApi {
  static const apiKey = 'fc4gkmh4ykdg';
  static const secret = 'h3gqj7wm6av5gnvch6zsjgsacesanpkbxvzyufu83d3svfchm3zb7fhajaw4dh8k';
  static final client = Client(apiKey, logLevel: Level.INFO);

  static Future initUser(
      Client client, {
        @required String username,
        @required String urlImage,
        @required String id,
        @required String token,
      }) async {
    final user = User(
      id: id,
      extraData: {
        'name': username,
        'image': urlImage,
      },
    );

    await client.setUser(user, token);
  }

  static Future<Channel> createChannel(
      Client client, {
        @required String type,
        @required String name,
        @required String id,
        @required String image,
        List<String> idMembers = const [],
      }) async {
    final channel = client.channel(type, id: id, extraData: {
      'name': name,
      'image': image,
      'members': idMembers,
    });

    await channel.create();

    channel.watch();
    return channel;
  }

  static Future<Channel> watchChannel(
      Client client, {
        @required String type,
        @required String id,
      }) async {
    final channel = client.channel(type, id: id);

    channel.watch();
    return channel;
  }}