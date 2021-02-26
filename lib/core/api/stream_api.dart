import 'package:flutter/foundation.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class StreamApi {
  static const apiKey = 'fc4gkmh4ykdg';
  static const secret =
      'h3gqj7wm6av5gnvch6zsjgsacesanpkbxvzyufu83d3svfchm3zb7fhajaw4dh8k';
  static final userToken =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiYml0dGVyLWxha2UtNiJ9.HImR18iZdf6SY_YCfrviCakuJjW-asVFNI-mqg6hreA";
  static final client = StreamChatClient(apiKey, logLevel: Level.SEVERE);

  static Future<Channel> createChannel(
    StreamChatClient client, {
    @required String type,
    @required String name,
    @required String id,
    @required String image,
    List<String> idMembers = const [],
  }) async {
    print('log de creation channel identification client $client');
    final channel = client.channel(type, id: id, extraData: {
      'name': name,
      'image': image,
      'members': idMembers,
    });

    print('log de creation channel identification channel $channel');
    await channel.create();

    final message = Message(
      text: type,
      extraData: {
        'customField': '123',
      }
    );
    print('log de creation message identification message $message');
    await channel.sendMessage(message);

    channel.watch();
    return channel;
  }

  static Future<Channel> watchChannel(
    StreamChatClient client, {
    @required String type,
    @required String id,
  }) async {
    print('log de watch channel identification client $client');

    final channel = client.channel(type, id: id);
    // final channel = client.channel('messaging', id: 'godevs');
    print('log de watch channel identification channel $channel');

    channel.watch();
    return channel;
  }

  static Future<Stream<List<Channel>>> channelList(
      StreamChatClient client, {
        @required String type,
        @required String id,
      }) async {
    print('log de watch channel identification client $client');

    final filter = {
      "type": type,
      "members": {
        "\$in": ["Rio Saeba"]
      }
    };

    final sort = [SortOption("last_message_at", direction: SortOption.DESC)];

    final channels = client.queryChannels(
      filter: filter,
      sort: sort,
    );
    print('log de watch channel identification channel $channels');

    return channels;
  }
}

