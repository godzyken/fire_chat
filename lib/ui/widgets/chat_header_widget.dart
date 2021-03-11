import 'package:fire_chat/core/models/models.dart';
import 'package:fire_chat/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatHeaderWidget extends StatelessWidget {
  final List<UserModel> users;

  const ChatHeaderWidget({
    @required this.users,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Center(
            child: Text(
              'Chats App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        Container(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: users?.length,
            itemBuilder: (context, index) {
              final user = users[index];
              if (index == 0) {
                return Container(
                  margin: EdgeInsets.only(right: 12),
                  child: CircleAvatar(
                    radius: 24,
                    child: Icon(Icons.search),
                  ),
                );
              } else {
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () => Get.offAll(() => ChatPage(userModel: user, members: [], channel: null)),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: (user?.photoUrl == null) ? AssetImage('assets/avatar/gaïmaito.jpg') : NetworkImage(user?.photoUrl),
                    ),
                  ),
                );
              }
            },
          ),
        )
      ],
    ),
  );
}