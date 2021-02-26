import 'package:fire_chat/core/api/api.dart';
import 'package:fire_chat/core/models/game_model.dart';
import 'package:fire_chat/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';

class BubbleGame3 extends StatefulWidget {
  final String title;

  const BubbleGame3({Key key, this.title}) : super(key: key);

  @override
  _BubbleGame3State createState() => _BubbleGame3State();
}

class _BubbleGame3State extends State<BubbleGame3> {
  String title = 'Bubble game 3';

  static const kAndroidUserAgent =
      'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

  String selectedUrl =
      'https://html5.gamedistribution.com/27673bc45d2e4b27b7cd24e422f7c257';

// ignore: prefer_collection_literals
  final Set<JavascriptChannel> jsChannels = [
    JavascriptChannel(
        name: 'Print',
        onMessageReceived: (JavascriptMessage message) {
          print(message.message);
        }),
  ].toSet();

  final flutterWebViewPlugin = FlutterWebviewPlugin();

  void saveGame() async {
    final GameModel gameModel = GameModel(name: title);
    await FirebaseApi.uploadGames(gameModel, selectedUrl);
  }

  @override
  void initState() {
    saveGame();

    super.initState();
  }

  @override
  void dispose() {
    saveGame();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        actions: [
          IconButton(
            icon: Icon(Icons.home_sharp),
            tooltip: 'Back to home',
            onPressed: () => Get.off(() => HomeUI()),
          ),
        ],
      ),
      url: selectedUrl,
      javascriptChannels: jsChannels,
      mediaPlaybackRequiresUserGesture: true,
      withLocalStorage: true,
    );
  }
}
