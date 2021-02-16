
import 'package:fire_chat/localizations.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:fire_chat/ui/ui.dart';

class SplashUI extends StatefulWidget {
  @override
  _SplashUIState createState() => _SplashUIState();
}

class _SplashUIState extends State<SplashUI> {


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return new SplashScreen(
      seconds: 15,
      navigateAfterSeconds: new HomeUI(),
      title: new Text(labels.splash.welcome,
          style: new TextStyle(
          fontWeight:  FontWeight.bold,
          fontSize: 20.0
      ),),
      image: new Image.asset('assets/avatar/gaïmaito.jpg'),
      backgroundColor: Colors.greenAccent,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.red,
    );
  }

}