import 'package:fire_chat/core/controllers/controllers.dart';
import 'package:fire_chat/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller?.tabIndex,
              children: [
                HomeUI(),
                ChatsPage(),
                ChannelListPage(),
                InterestFormUi(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: controller?.changeTabIndex,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.grey.shade600,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            type: BottomNavigationBarType.fixed,
            currentIndex: controller?.tabIndex,
            elevation: 0,
            iconSize: 38,
            items: [
              _bottomNavigationBarItem(
                icon: Icons.home,
                label: "home",
                // activeIcon: HomeUI(),
              ),
              _bottomNavigationBarItem(
                icon: Icons.message,
                label: "chats-page",
                // activeIcon: ChatsPage(),
              ),
              _bottomNavigationBarItem(
                icon: Icons.group_work,
                label: "channel-list",
                // activeIcon: ChannelListPage(),
              ),
              _bottomNavigationBarItem(
                icon: Icons.account_box,
                label: "interest-profile",
                // activeIcon: UpdateProfileUI(),
              ),
            ],
          ),
        );
      },
    );
  }

  _bottomNavigationBarItem({IconData icon, String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
