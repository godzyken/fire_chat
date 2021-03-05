import 'package:fire_chat/ui/pages/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActiveUsersRowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => buildCreateRoom(context);

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
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    ),
  );
}