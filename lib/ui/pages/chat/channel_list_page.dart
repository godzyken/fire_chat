import 'package:fire_chat/core/api/api.dart';
import 'package:fire_chat/core/controllers/auth_controller.dart';
import 'package:fire_chat/core/models/models.dart';
import 'package:fire_chat/ui/ui.dart';
import 'package:fire_chat/users.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChannelListPage extends StatelessWidget {
  const ChannelListPage({Key key}) : super(key: key);

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );

  @override
  Widget build(BuildContext context) => StreamBuilder<List<ChannelModel>>(
      stream: FirebaseApi.getChannelModels(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return buildText('Something Went Wrong Try Later');
            } else {
              final channels = snapshot.data;

              return channels.isEmpty
                  ? Scaffold(
                      appBar: AppBar(
                        centerTitle: true,
                        title: Text('Channel Lists'),
                        backwardsCompatibility: true,
                        actions: [
                          IconButton(
                            icon: Icon(Icons.home_sharp),
                            tooltip: 'Back to home',
                            onPressed: () => Get.off(() => HomeUI()),
                          ),
                        ],
                      ),
                      body: Container(child: buildText('Create a Channel')),
                      bottomSheet: FutureBuilder<ChannelModel>(
                          builder: (context, snapshot) {
                        return ChannelWidget(
                          channelModel: snapshot.data,
                          isMe: snapshot.data?.user?.uid ==
                              AuthController.to?.firestoreUser?.value?.uid,
                        );
                      }),
                    )
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      reverse: false,
                      itemCount: channels.length,
                      itemBuilder: (context, index) {
                        final channel = channels[index];

                        return GestureDetector(
                          onTap: () {},
                          child: buildContainer(channel),
                        );
                      });
            }
        }
      });

  Container buildContainer(ChannelModel channel) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(channel.user.photoUrl),
                  maxRadius: 30,
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          channel.name,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          channel.msgs.message,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: channel.msgs.username.isEmpty
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            channel.msgs.createdAt.toString(),
            style: TextStyle(
                fontSize: 12,
                fontWeight: channel.user.uid.isEmpty
                    ? FontWeight.bold
                    : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
