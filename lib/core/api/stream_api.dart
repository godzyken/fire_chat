import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_persistence/stream_chat_persistence.dart';

class StreamApi {
  static const apiKey = 'fc4gkmh4ykdg';

  static final client = StreamChatClient(
    // 's2dxdhpxd94g',
    apiKey,
    logLevel: Level.INFO,
    connectTimeout: Duration(milliseconds: 6000),
    receiveTimeout: Duration(milliseconds: 6000),
  );



  static final chatPersistentClient = StreamChatPersistenceClient(
    logLevel: Level.INFO,
    connectionMode: ConnectionMode.background,
  );


}
