import 'package:fire_chat/core/models/models.dart';
import 'package:fire_chat/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<UserModel> users;

  const ChatBodyWidget({
    @required this.users,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: buildChats(),
    ),
  );

  Widget buildChats() => ListView.builder(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) {
      final user = users[index];

      return Container(
        height: 75,
        child: ListTile(
          onTap: () => Get.offAll(() => ChatPage()),
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(user.photoUrl),
          ),
          title: Text(user.name),
        ),
      );
    },
    itemCount: users.length,
  );
}