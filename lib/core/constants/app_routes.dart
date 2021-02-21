
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
    GetPage(name: '/dashboard', page: () => DashboardPage()),
    GetPage(name: '/home', page: () => HomeUI()),
    GetPage(name: '/settings', page: () => SettingsUI()),
    GetPage(name: '/reset-password', page: () => ResetPasswordUI()),
    GetPage(name: '/update-profile', page: () => UpdateProfileUI()),

    GetPage(name: '/channel-page', page: () => ChannelPage()),
    GetPage(name: '/channel-list', page: () => ChannelListPage()),
    GetPage(name: '/chat-page', page: () => ChatPage(user: null,)),
    GetPage(name: '/chats-page', page: () => ChatsPage()),
    GetPage(name: '/create-channel', page: () => CreateChannelPage(channelModel: null,)),

  ];
}