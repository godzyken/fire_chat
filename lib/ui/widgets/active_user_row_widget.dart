import 'package:fire_chat/core/api/api.dart';
import 'package:fire_chat/core/models/models.dart';
import 'package:fire_chat/ui/pages/chat/chat.dart';
import 'package:fire_chat/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ActiveUsersRowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => FutureBuilder<List<UserModel>>(
        future: StreamUserApi.getAllUsers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Something Went Wrong Try later'));
              } else {
                final users = snapshot.data;

                return buildActiveUsers(context, users);
              }
          }
        },
      );

  Widget buildActiveUsers(BuildContext context, List<UserModel> users) =>
      ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: users.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return buildCreateRoom(context);
          } else {
            final user = users[index - 1];

            return buildActiveUser(context, user);
          }
        },
      );

  Widget buildActiveUser(BuildContext context, UserModel user) => Container(
        width: 75,
        padding: const EdgeInsets.all(4),
        child: GestureDetector(
          onTap: () async {
            final currentChannel = await StreamChannelApi.searchChannel(
              idUser: user.uid,
              username: user.name,
            );

            if (currentChannel == null) {
              final channel = await StreamChannelApi.createChannelWithUsers(
                context,
                name: user.name,
                urlImage: user.photoUrl,
                idMembers: [user.uid],
              );


              Get.offAll(() => ChatPage(channel: channel, userModel: user, members: [],),
              );
            } else {
              GetBuilder(
                builder: (context) =>
                    ChatPageMobile(channel: null,),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProfileImageWidget(
                imageUrl: user.photoUrl,
                radius: 25,
              ),
              Text(
                user.name,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.yellow),
              ),
            ],
          ),
        ),
      );

  Widget buildCreateRoom(BuildContext context) => GestureDetector(
        onTap: () => Get.offAll(() => MembersPage()),
        child: Container(
          width: 75,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade100,
                child: Icon(Icons.video_call, size: 28, color: Colors.black),
                radius: 25,
              ),
              Text(
                'Create\nRoom',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.yellowAccent),
              ),
            ],
          ),
        ),
      );
}
