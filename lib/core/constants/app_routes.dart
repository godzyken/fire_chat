
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
    GetPage(name: '/home', page: () => HomeUI()),
    GetPage(name: '/settings', page: () => SettingsUI()),
    GetPage(name: '/reset-password', page: () => ResetPasswordUI()),
    GetPage(name: '/update-profile', page: () => UpdateProfileUI()),
    GetPage(name: '/interest-profile', page: () => InterestFormUi()),

    GetPage(name: '/hextris-page', page: () => Hextris()),
    GetPage(name: '/bubble-page', page: () => BubbleGame3()),
    GetPage(name: '/game-list', page: () => GameList()),
    GetPage(name: '/chat-page', page: () => ChatPage(user: null,)),
    GetPage(name: '/chat-home-page', page: () => ChatHomePage()),
    GetPage(name: '/chats-page', page: () => ChatsPage()),
    GetPage(name: '/create-channel', page: () => CreateChannelPage(members: [],)),

  ];
}