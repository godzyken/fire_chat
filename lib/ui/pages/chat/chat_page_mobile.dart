
import 'package:fire_chat/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatPageMobile extends StatefulWidget {
  final Channel channel;

  const ChatPageMobile({
    @required this.channel,
  });


  @override
  _ChatPageMobileState createState() => _ChatPageMobileState();
}

class _ChatPageMobileState extends State<ChatPageMobile> {
  final channelListController = ChannelListController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: ChannelsBloc(
        child: ChannelListCore(
          channelListController: channelListController,
          filter: {
            'type': 'messaging',
            'members': {
              r'$in': [
                StreamChatCore
                    .of(context)
                    .user
                    .id,
              ]
            }
          },
          emptyBuilder: (BuildContext context) {
            return Center(
              child: Text('Looks like you are not in any channels'),
            );
          },
          loadingBuilder: (BuildContext context) {
            return Center(
              child: SizedBox(
                height: 100.0,
                width: 100.0,
                child: CircularProgressIndicator(),
              ),
            );
          },
          errorBuilder: (BuildContext context, dynamic error) {
            return Center(
              child: Text(
                  'Oh no, something went wrong. Please check your config.'),
            );
          },
          listBuilder: (BuildContext context,
              List<Channel> channels,) =>
              LazyLoadScrollView(
                onEndOfPage: () async {
                  channelListController.paginateData();
                },
                child: ListView.builder(
                  itemCount: channels.length,
                  itemBuilder: (BuildContext context, int index) {
                    final _item = channels[index];
                    return ListTile(
                      title: Text(_item.id),
                      subtitle: StreamBuilder<Message>(
                        stream: _item.state.lastMessageStream,
                        initialData: _item.state.lastMessage,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data.text);
                          }

                          return SizedBox();
                        },
                      ),
                      onTap: () {
                        /// Display a list of messages when the user taps on an item.
                        /// We can use [StreamChannel] to wrap our [MessageScreen] screen
                        /// with the selected channel.
                        ///
                        /// This allows us to use a built-in inherited widget for accessing
                        /// our `channel` later on.
                        GetBuilder(
                            builder: (context) =>
                                StreamChannel(
                                  channel: _item,
                                  child: MessagesWidget(idUser: _item.cid),
                                ),
                        );
                      },
                    );
                  },
                ),
              ),
        ),
      ),
    );
  }

  Widget buildAppBar() {
    final channelName = widget.channel.extraData['name'];

    return AppBar(
      backgroundColor: Colors.white,
      title: Text(channelName),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.phone),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.videocam),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}