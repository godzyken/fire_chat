import 'package:fire_chat/core/api/api.dart';
import 'package:fire_chat/core/constants/constants.dart';
import 'package:fire_chat/core/controllers/controllers.dart';
import 'package:fire_chat/localizations.dart';
import 'package:fire_chat/ui/ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<AuthController>(AuthController());
  Get.put<ThemeController>(ThemeController());
  Get.put<LanguageController>(LanguageController());
  await GetStorage.init();
  await Firebase.initializeApp();

  final client = StreamApi.client;
  await client.connectUser(
    User(
      id: 'cool-shadow-7',
      extraData: {
        'image':
        'https://getstream.io/random_png/?id=cool-shadow-7&amp;name=Cool+shadow',
      },
    ),
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiY29vbC1zaGFkb3ctNyJ9.gkOlCRb1qgy4joHPaxFwPOdXcGvSPvp6QY0S4mpRkVo',
  );

  runApp(MyApp(client: client));
}

class MyApp extends StatefulWidget {
  final StreamChatClient client;

  const MyApp({Key key, @required this.client}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeModeFromStore();
    return GetBuilder<LanguageController>(
      builder: (languageController) => StreamChatCore(
        client: StreamApi.client,
        child: Loading(
          child: GetMaterialApp(
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

