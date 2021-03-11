import 'package:fire_chat/core/api/api.dart';
import 'package:fire_chat/core/controllers/controllers.dart';
import 'package:fire_chat/core/models/models.dart';
import 'package:fire_chat/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatPage extends StatefulWidget {
  final List<UserModel> members;
  final UserModel userModel;

  final Channel channel;

  const ChatPage({
    @required this.userModel,
    @required this.channel,
    Key key, this.members,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChannelController controller = ChannelController.to;

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
            Expanded(
              flex: 1,
              child: ProfileHeaderWidget(
                  name: widget.channel.config.name,
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: MessagesWidget(idUser: '${widget?.members?.iterator?.current?.uid}'),
              ),
            ),
            Expanded(
              flex: 1,
                child: NewMessageWidget(idUser: widget?.userModel))
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
            Expanded(
              flex: 1,
              child: ProfileHeaderWidget(name: '${controller.channelName}'),),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: MessagesWidget(idUser: widget?.members?.iterator?.current?.uid),
              ),
            ),
            Expanded(
              flex: 1,
                child: NewMessageWidget(idUser: widget?.userModel))
          ],
        ),
      ),
    ));
  }
}
