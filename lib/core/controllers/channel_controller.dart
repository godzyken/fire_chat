
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelController extends GetxController {
  static ChannelController to = Get.find();

  Channel _selectedChannel;

  Channel get selectedChannel => _selectedChannel;

  void setChannel(Channel channel) {
    _selectedChannel = channel;
    update();
  }
}