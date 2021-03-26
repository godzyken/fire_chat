import 'package:fire_chat/core/api/api.dart';
import 'package:fire_chat/core/constants/constants.dart';
import 'package:fire_chat/core/controllers/controllers.dart';
import 'package:fire_chat/localizations.dart';
import 'package:fire_chat/ui/ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<AuthController>(AuthController());
  Get.put<ChannelController>(ChannelController());
  Get.put<ThemeController>(ThemeController());
  Get.put<LanguageController>(LanguageController());
  await GetStorage.init();
  await Firebase.initializeApp();

  final client = StreamApi.client;
/*  final idUser = await AuthController.to?.firebaseUser?.value;
  final token = await StreamUserApi.login(uid: idUser.uid);*/
  await client.connectUser(
    User(
      id: 'cool-shadow-7',
      role: 'user',
      extraData: {
        'image':
            'https://getstream.io/random_png/?id=cool-shadow-7&amp;name=Cool+shadow',
      },
      online: true,
      updatedAt: DateTime.now(),
      teams: [],
      banned: false,
      createdAt: DateTime.now(),
      lastActive: DateTime.now(),
    ),
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiY29vbC1zaGFkb3ctNyJ9.gkOlCRb1qgy4joHPaxFwPOdXcGvSPvp6QY0S4mpRkVo',
  );

  final channel = client.channel('messaging', id: 'godevs',

/*      extraData: {
    'connection_id': client.connectionId,
    'me': client.state.user,
    'user': client,
    'channel': client.state.channelsStream,
    'member': client.state.users
  }*/

  );

  channel.watch();

  await channel.watch();

  runApp(MyApp(client: client, channel: channel));
}

class MyApp extends StatefulWidget {
  final StreamChatClient client;

  final Channel channel;

  const MyApp({Key key, @required this.client, @required this.channel})
      : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeModeFromStore();
    Get.config(
      defaultTransition: Transition.cupertino,
      enableLog: true,
      defaultPopGesture: true,
    );
    return GetBuilder<LanguageController>(
      builder: (languageController) => StreamChatCore(
        client: StreamApi.client,
        child: Loading(
          rxStatus: RxStatus.loading(),
          child: GetMaterialApp(
            enableLog: true,
            defaultTransition: Transition.fade,
            opaqueRoute: Get.isOpaqueRouteDefault,
            popGesture: Get.isPopGestureEnable,
            transitionDuration: Get.defaultTransitionDuration,
            locale: languageController.getLocale,
            localizationsDelegates: [
              const AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.languages.keys.toList(),
            navigatorObservers: [
              // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
            ],
            debugShowCheckedModeBanner: false,
            //defaultTransition: Transition.fade,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: ThemeMode.system,
            initialRoute: "/",
            getPages: AppRoutes.routes,
          ),
        ),
      ),
    );
  }
}
