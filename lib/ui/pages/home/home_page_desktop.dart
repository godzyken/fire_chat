import 'package:fire_chat/core/controllers/channel_controller.dart';
import 'package:fire_chat/ui/pages/chat/chat.dart';
import 'package:fire_chat/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat/stream_chat.dart';

class HomePageDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectedChannel =
        ChannelController.to.selectedChannel;

    return Scaffold(
      body: Row(
        children: [
          Expanded(child: buildChats(context)),
          VerticalDivider(indent: 0, endIndent: 0, thickness: 0.5, width: 0.5),
          Expanded(flex: 3, child: buildChat(selectedChannel))
        ],
      ),
    );
  }

  Widget buildChats(BuildContext context) => Column(
    children: [
      AppBar(
        leading: UserImageWidget(),
        title: Text('Chats'),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: Icon(Icons.edit, size: 20, color: Colors.black),
          ),
          SizedBox(width: 8),
        ],
      ),
      Expanded(child: ChatsPage()),
    ],
  );

  Widget buildChat(Channel selectedChannel) {
    if (selectedChannel == null) {
      return Center(
        child: Text(
          'Select A Chat',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return ChatPageMobile(channel: selectedChannel);
  }
}