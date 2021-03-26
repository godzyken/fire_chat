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
      body: Column(
        children: <Widget>[
          Expanded(

            child: MessageListView(
              threadBuilder: (_, parentMessage) {
                return ThreadPage(
                  parent: parentMessage,
                );
              },
              messageBuilder: _messageBuilder,
            ),
          ),
          MessageInput(),
        ],
      ),
    );
  }

  Widget _messageBuilder(
      BuildContext context,
      MessageDetails details,
      List<Message> messages,
      ) {
    final message = details.message;
    final isCurrentUser = StreamChat.of(context).user.id == message.user.id;
    final textAlign = isCurrentUser ? TextAlign.right : TextAlign.left;
    final color = isCurrentUser ? Colors.blueGrey : Colors.blue;

    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: ListTile(
          title: Text(
            message.text,
            textAlign: textAlign,
          ),
          subtitle: Text(
            message.user.extraData['name'],
            textAlign: textAlign,
          ),
        ),
      ),
    );
  }
}

class ThreadPage extends StatelessWidget {
  final Message parent;

  ThreadPage({
    Key key,
    this.parent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThreadHeader(
        parent: parent,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MessageListView(
              parentMessage: parent,
            ),
          ),
          MessageInput(
            parentMessage: parent,
          ),
        ],
      ),
    );
  }
}
