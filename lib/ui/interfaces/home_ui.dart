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
                      title: Text('My Files'),
                      leading: Icon(Icons.folder),
                      onTap: () => Get.to(() => ChatPage(user: controller.firestoreUser.value)),
                    ),
                    ListTile(
                      title: Text('Contact list'),
                      leading: Icon(Icons.people),
                      onTap: () => Get.offAll(() => ChannelListPage()),
                    ),
                    ListTile(
                      title: Text('Starred'),
                      leading: Icon(Icons.star),
                      onTap: () {
                        print("Clicked");
                      },
                    ),
                    ListTile(
                      title: Text('location'),
                      leading: Icon(Icons.location_on),
                      onTap: () {
                        print("Clicked");
                      },
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
              body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/img/marlonW.jpg'),
                  fit: BoxFit.cover,
                )),
              ),
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Colors.red,
                unselectedItemColor: Colors.grey.shade600,
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.message),
                    label: "Chats",
                    // activeIcon: ChatPage(),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.group_work),
                    label: "Channels",
                    // activeIcon: ChannelListPage(),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_box),
                    label: "Profile",
                    // activeIcon: UpdateProfileUI(),
                  ),
                ],
              ),
            ),
    );
  }
}
