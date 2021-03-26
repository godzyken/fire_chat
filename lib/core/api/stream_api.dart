import 'package:fire_chat/core/api/api.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_persistence/stream_chat_persistence.dart';

class StreamApi {
  static const apiKey = 'fc4gkmh4ykdg';

  static final client = StreamChatClient(
    // 's2dxdhpxd94g',
    apiKey,
    logLevel: Level.INFO,
    baseURL: 'https://chat-us-east-1.stream-io-api.com',
    // baseURL: 'http://localhost:5001/flutterauth-demo/us-central1/createToken',
    // tokenProvider: (userId) => StreamUserApi.login(uid: userId),
    connectTimeout: Duration(milliseconds: 6000),
    receiveTimeout: Duration(milliseconds: 6000),
  )..chatPersistenceClient = chatPersistentClient;

  static final chatPersistentClient = StreamChatPersistenceClient(
    logLevel: Level.INFO,
    connectionMode: ConnectionMode.background,
  );

}
