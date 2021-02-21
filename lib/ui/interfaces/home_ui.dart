import 'package:fire_chat/core/controllers/controllers.dart';
import 'package:fire_chat/localizations.dart';
import 'package:fire_chat/ui/interfaces/interfaces.dart';
import 'package:fire_chat/ui/pages/chat/channel_list_page.dart';
import 'package:fire_chat/ui/pages/chat/chat.dart';
import 'package:fire_chat/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeUI extends StatefulWidget {
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => controller?.firestoreUser?.value?.uid == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text(labels?.home?.title),
                actions: [
                  IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        Get.to(() => SettingsUI());
                      }),
                ],
                automaticallyImplyLeading: true,
              ),
              drawer: Drawer(
                child: ListView(
                  children: <Widget>[
                    Container(
                      child: UserAccountsDrawerHeader(
                        currentAccountPicture:
                            Avatar(controller.firestoreUser.value),
                        accountName: Text(
                            labels.home.nameLabel +
                                ': ' +
                                controller.firestoreUser.value.name,
                            style: TextStyle(fontSize: 16)),
                        accountEmail: Text(
                            labels.home.emailLabel +
                                ': ' +
                                controller.firestoreUser.value.email,
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    ListTile(
                      title: Text('Channel list'),
                      leading: Icon(Icons.people),
                      onTap: () => Get.offAll(() => ChannelListPage()),
                    ),
                    ListTile(
                      title: Text('chats-page'),
                      leading: Icon(Icons.chat_bubble_outlined),
                      onTap: () => Get.to(() => ChatsPage()),
                    ),
                    ListTile(
                      title: Text('dashboard'),
                      leading: Icon(Icons.dashboard),
                      onTap: () => Get.to(() => DashboardPage()),
                    ),
                    ListTile(
                      title: Text('Video Call'),
                      leading: Icon(Icons.video_call),
                      onTap: () {
                        print("Clicked");
                      },
                    ),
                    ListTile(
                      title: Text('Uploads'),
                      leading: Icon(Icons.file_upload),
                      onTap: () {
                        print("Clicked");
                      },
                    ),
                    ListTile(
                      title: Text('Backups'),
                      leading: Icon(Icons.backup),
                      onTap: () {
                        print("Clicked");
                      },
                    ),
                    ListTile(
                      title: Text('My Card'),
                      leading: Icon(Icons.account_circle),
                      onTap: () {
                        print("Clicked");
                      },
                    ),
                  ],
                ),
              ),
              body: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/img/marlonW.jpg'),
                    fit: BoxFit.cover,
                  )),
                ),
              ),
            ),
    );
  }
}
