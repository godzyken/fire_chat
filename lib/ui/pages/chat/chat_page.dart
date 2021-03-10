import 'package:fire_chat/core/api/api.dart';
import 'package:fire_chat/core/models/models.dart';
import 'package:fire_chat/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatPage extends StatefulWidget {
  final List<UserModel> user;
  final Channel channel;

  const ChatPage({
    @required this.user,
    @required this.channel,
    Key key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => widget.channel != null ? buildStreamChannel : buildStreamChat;

  StreamChannel get buildStreamChannel {
    return StreamChannel(
    channel: widget.channel,
    child: Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ProfileHeaderWidget(name: widget?.user?.first?.name),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: MessagesWidget(idUser: widget?.user?.single?.uid),
              ),
            ),
            NewMessageWidget(idUser: widget.user.single)
          ],
        ),
      ),
    ));
  }

  StreamChat get buildStreamChat {
    return StreamChat(
    client: StreamApi.client,
    child: Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ProfileHeaderWidget(name: widget?.user?.first?.name),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: MessagesWidget(idUser: widget?.user?.single?.uid),
              ),
            ),
            NewMessageWidget(idUser: widget.user.single)
          ],
        ),
      ),
    ));
  }
}
