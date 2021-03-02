import 'package:fire_chat/ui/pages/chat/chat.dart';
import 'package:flutter/material.dart';

class ChatHomePage extends StatefulWidget {
  final int tabIndex;

  const ChatHomePage({
    Key key,
    this.tabIndex = 0,
  }) : super(key: key);

  @override
  _ChatHomePageState createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  int tabIndex;

  @override
  void initState() {
    tabIndex = widget.tabIndex;
    super.initState();
  }

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
              icon: Icon(Icons.chat),
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
