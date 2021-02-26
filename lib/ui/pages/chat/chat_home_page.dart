import 'package:fire_chat/ui/pages/chat/chat.dart';
import 'package:flutter/material.dart';

class ChatHomePage extends StatefulWidget {
  @override
  _ChatHomePageState createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  int tabIndex = 1;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: IndexedStack(
      index: tabIndex,
      children: [
        ChatsPage(),
        PeoplePage(),
      ],
    ),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: tabIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black38,
      onTap: (index) => setState(() => tabIndex = index),
      items: [
        BottomNavigationBarItem(
          icon:  Icon(Icons.chat),
          label: 'Chats',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'People',
        ),
      ],
    ),
  );
}
