import 'package:flutter/foundation.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class StreamApi {
  static const apiKey = 'fc4gkmh4ykdg';
  static const secret =
      'h3gqj7wm6av5gnvch6zsjgsacesanpkbxvzyufu83d3svfchm3zb7fhajaw4dh8k';
/*
  static final userToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6Iklra2kgRGFjdGV1IERyZSIsImlhdCI6MTUxNjIzOTAyMn0.p5ZKMBMY3Z1Jcxp8HcWAp8aI-2DKdmQlD5eio5Z7c-g";
  // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6Iklra2kgRGFjdGV1IERyZSIsImlhdCI6MTUxNjIzOTAyMn0.vPaxml2rQMwKoiXq0tyY7yjjQiHRi_Q2pnbxGnpTLoE";
  static final String idIkki = 'falling-mountain-7';

  static final tokenDaddy =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkRhZGR5IiwiaWF0IjoxNTE2MjM5MDIyfQ.8DKccbk1PoWRPoZvr5CaLWxMV_xMslduhJBVzNCPGdY";
      // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkRhZGR5IiwiaWF0IjoxNTE2MjM5MDIyfQ.uPxKQggvWy7HIlfcf5Tm4YhB8LRKyluKLC2XJkdHTCc";
  static final String idDaddy = 'jlahey';

  static Future initUser(
    StreamChatClient client, {
    @required String username,
    @required String urlImage,
    @required String id,
    @required String token,
  }) async {
    final user = User(id: id, extraData: {
      'name': username,
      'image': urlImage,
    });

    await client.connectUser(user, token);
  }
*/

  static final client = StreamChatClient(
    // 's2dxdhpxd94g',
    apiKey,
    logLevel: Level.SEVERE,
    connectTimeout: Duration(milliseconds: 6000),
    receiveTimeout: Duration(milliseconds: 6000),
  );



  /*static Future<Channel> watchChannel(
    StreamChatClient client, {
    @required String type,
    @required String id,
  }) async {
    final channel = client.channel(type, id: id);

    channel.watch();
    return channel;
  }

  static Future<Stream<List<Channel>>> channelList(
    StreamChatClient client, {
    @required String type,
    @required String id,
  }) async {
     final filter = {
      "type": type,
      "members": {
        "\$in": [id]
      }
    };

    final sort = [SortOption("last_message_at", direction: SortOption.DESC)];

    final channels = client.queryChannels(
      filter: filter,
      sort: sort,
    );

    return channels;
  }*/
}
