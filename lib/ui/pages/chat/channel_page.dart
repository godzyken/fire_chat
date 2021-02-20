import 'package:fire_chat/ui/pages/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelPage extends StatelessWidget {
  const ChannelPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChannelHeader(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    MessageListView(
                      threadBuilder: (_, parentMessage) {
                        return ThreadPage(
                          parent: parentMessage,
                        );
                      },
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4,
                        ),
                        child: TypingIndicator(
                          alignment: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ],
                ),
                MessageInput(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}