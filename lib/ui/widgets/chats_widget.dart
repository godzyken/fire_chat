import 'package:fire_chat/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final idUser = StreamChat.of(context)?.user?.id;

    return ChannelListView(
      filter: {
        'members': {
          '\$in': [idUser],
        }
      },
      sort: [SortOption('last_message_at', direction: SortOption.DESC)],
      pagination: PaginationParams(limit: 20),
      channelPreviewBuilder: (context, channel) =>
          ChannelListWidget(channel: channel),
    );
  }
}