import 'package:fire_chat/core/controllers/controllers.dart';
import 'package:fire_chat/localizations.dart';
import 'package:fire_chat/ui/interfaces/interfaces.dart';
import 'package:fire_chat/ui/pages/home/home.dart';
import 'package:fire_chat/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeUI extends StatefulWidget {
  final int tabIndex;

  const HomeUI({Key key, @required this.tabIndex}) : super(key: key);

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
    ResponsiveBuilder(
      builder: (context, sizingInfo) => sizingInfo.isDesktop
      ? HomePageDesktop() : HomeUI(tabIndex: widget.tabIndex),
    );
    return buildGetBuilder(labels);
  }

  GetBuilder<AuthController> buildGetBuilder(AppLocalizations_Labels labels) {
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
                    title: Text('Contact list'),
                    leading: Icon(Icons.people),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('Hextris Game'),
                    leading: Icon(Icons.gamepad_outlined),
                    onTap: () => Get.offAll(() => Hextris()),
                  ),
                  ListTile(
                    title: Text('Bubble Game 3'),
                    leading: Icon(Icons.file_upload),
                    onTap: () => Get.offAll(() => BubbleGame3()),
                  ),
                  ListTile(
                    title: Text('Game List'),
                    leading: Icon(Icons.list_alt_outlined),
                      onTap: () => Get.offAll(() => GameList()),
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
                child: GestureDetector(
                  onDoubleTap: () {
                    print("DOUBLE TAB");
                    Get.off(() => DashboardWidget());
                  },
                ),
              ),
            ),
          ),
  );
  }
}
