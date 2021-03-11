import 'package:fire_chat/core/api/api.dart';
import 'package:fire_chat/core/models/models.dart';
import 'package:fire_chat/ui/pages/chat/chat.dart';
import 'package:fire_chat/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:intl/intl.dart';

class ChannelListWidget extends StatelessWidget {
  final Channel channel;

  const ChannelListWidget({
    Key key,
    @required this.channel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = channel.extraData['name'];
    final urlImage = channel.extraData['image'];
    final memberIds = channel.extraData['members'];

    final hasMessage = channel.state.messages.isNotEmpty;
    final lastMessage = hasMessage ? channel.state.messages.last.text : '';
    final lastMessageAt = _formatDateTime(channel.lastMessageAt);

    evictImage(String urlImage) {
      final NetworkImage provider = NetworkImage(urlImage);
      provider.evict().then<void>((bool success) {
        if (success) debugPrint('removed image!');
      });
    }

    return StreamChat(
        client: StreamApi.client,
        child: buildChannel(
          context,
          channel: channel,
          name: name,
          urlImage: urlImage,
          lastMessage: lastMessage,
          lastMessageAt: lastMessageAt,
          members: memberIds,
        ));
  }

  Widget buildChannel(
    BuildContext context, {
    @required Channel channel,
    @required String name,
    @required String urlImage,
    @required String lastMessage,
    @required String lastMessageAt,
    @required String members,
    UserModel userModel,
  }) =>
      ListTile(
        onTap: () => Get.offAll(() => ChatPage(
              channel: channel,
              members: [],
              userModel: userModel,
            )),
        leading: ProfileImageWidget(imageUrl: urlImage),
        title: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.yellow),
        ),
        subtitle: Row(
          children: [
            Expanded(
                child: Text(
              lastMessage,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.redAccent),
            )),
            Text(lastMessageAt,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.yellow)),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide.none,
        ),
        hoverColor: Colors.blue,
      );

  String _formatDateTime(DateTime lastMessageAt) {
    if (lastMessageAt == null) return '';

    final isRecently = lastMessageAt.difference(DateTime.now()).inDays == 0;
    final dateFormat = isRecently ? DateFormat.jm() : DateFormat.MMMd();

    return dateFormat.format(lastMessageAt);
  }
}
