
import 'package:fire_chat/core/models/models.dart';
import 'package:fire_chat/ui/pages/chat/chat.dart';
import 'package:fire_chat/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final idUser = StreamChat.of(context).user?.id;
    final client = StreamChat.of(context).client;
    final type = 'messaging';
    final channel = client.channel(type);
    UserModel userModel;

    channel.watch();

    return ChannelListView(
      onStartChatPressed: () => ChatPage(channel:channel, members: [], userModel: userModel,),
      filter: {
        'members': {
          '\$in': [idUser],
        }
      },
      sort: [SortOption('last_message_at', direction: SortOption.DESC)],
      pagination: PaginationParams(limit: 10),
      channelWidget: ChannelWidget(channel: channel, isMe: true),
      channelPreviewBuilder: (context, channel) => StreamChannel(
          showLoading: true,
          channel: channel,
          child: ChannelListWidget(channel: channel)),
    );
  }
}
