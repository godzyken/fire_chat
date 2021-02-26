import 'package:fire_chat/core/api/api.dart';
import 'package:fire_chat/core/constants/constants.dart';
import 'package:fire_chat/core/controllers/controllers.dart';
import 'package:fire_chat/localizations.dart';
import 'package:fire_chat/ui/ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<AuthController>(AuthController());
  Get.put<ThemeController>(ThemeController());
  Get.put<LanguageController>(LanguageController());
  await GetStorage.init();
  await Firebase.initializeApp();

 /* final uid = '2b2f371d-06a0-4731-b5fc-74b31ea99fbc';
  await StreamUserApi.login(uid: uid);*/

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Firebase Chat';

  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeModeFromStore();
    return GetBuilder<LanguageController>(
      builder: (languageController) => StreamChat(
        streamChatThemeData: StreamChatThemeData(),
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

