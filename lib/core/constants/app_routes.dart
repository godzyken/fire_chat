
import 'package:fire_chat/ui/pages/pages.dart';
import 'package:fire_chat/ui/ui.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => SplashUI()),
    GetPage(name: '/sign-in', page: () => SignInUI()),
    GetPage(name: '/sign-up', page: () => SignUpUI()),
    GetPage(name: '/login-selector', page: () => LoginSelectorUi(plugin: null,)),
    GetPage(name: '/dashboard', page: () => DashboardWidget()),
    GetPage(name: '/home', page: () => HomeUI(tabIndex: 0,)),
    GetPage(name: '/settings', page: () => SettingsUI()),
    GetPage(name: '/reset-password', page: () => ResetPasswordUI()),
    GetPage(name: '/update-profile', page: () => UpdateProfileUI()),
    GetPage(name: '/interest-profile', page: () => InterestFormUi()),

    GetPage(name: '/hextris-page', page: () => Hextris()),
    GetPage(name: '/bubble-page', page: () => BubbleGame3()),
    GetPage(name: '/game-list', page: () => GameList()),
    GetPage(name: '/chat-page', page: () => ChatPage(userModel: null, channel: null, members: [],)),
    GetPage(name: '/chat-page-mobile', page: () => ChatPageMobile(channel: null,)),
    GetPage(name: '/chats-page', page: () => ChatsPage()),
    GetPage(name: '/create-channel', page: () => CreateChannelPage(members: [])),
    GetPage(name: '/channel-list', page: () => ChannelListPage()),
    GetPage(name: '/channel', page: () => ChannelPage()),
    GetPage(name: '/add-members', page: () => MembersPage()),

    GetPage(name: '/profile', page: () => InterestFormUi()),

  ];
}