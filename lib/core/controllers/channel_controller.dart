
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

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
}