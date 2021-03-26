
import 'package:fire_chat/core/api/api.dart';
import 'package:fire_chat/core/models/models.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_persistence/stream_chat_persistence.dart';

class ChannelController extends GetxController {
  static ChannelController to = Get.find();

  Channel _selectedChannel;
  final state = ['isCurrent', 'isOdl'].obs;
  final store = GetStorage();

  var channelName = 'Test-channel'.obs;

  Channel get selectedChannel => _selectedChannel;

  Map<String, dynamic> get channelData => null;

  void setChannel(Channel channel) {
    _selectedChannel = channel;
    update();
  }
  
  Future<void> updateChannelList(Channel channel) async {
    _selectedChannel = channel;
    await store.write('state', channel);
    channel.update(channelData);
  }

  Future<void> createStreamConnection(UserModel user, User _firebaseUser) async {
    StreamChatPersistenceClient(
      logLevel: Level.INFO,
      connectionMode: ConnectionMode.regular,
    );
    final status = StreamApi.client.wsConnectionStatus;
    print('Status is @@@@@ $status');

    final apiKey = StreamApi.client.apiKey;
    print('ApiKey is @@@@@ $apiKey');

    final userToken = StreamApi.client.token;
    print('userToken is @@@@@ $userToken');

    final client = StreamChatClient(apiKey, logLevel: Level.INFO);
    print('Client is @@@@@ $client');

    await client.connectUser(
      User(id: _firebaseUser.id),
      userToken,
    );
  }

  Future<void> createStreamChannel(UserModel user, Channel channel) async {
    final response = StreamApi.client.channel(
      channel.type,
      id: user.uid,
      extraData: {
        'name': channelName
      },
    );

    await response.watch();

  }
}