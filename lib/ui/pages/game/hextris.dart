import 'dart:async';

import 'package:fire_chat/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';

class Hextris extends StatefulWidget {
  @override
  _HextrisState createState() => _HextrisState();
}

class _HextrisState extends State<Hextris> {
  static const kAndroidUserAgent =
      'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

  String selectedUrl = 'https://hextris.io';

// ignore: prefer_collection_literals
  final Set<JavascriptChannel> jsChannels = [
    JavascriptChannel(
        name: 'Print',
        onMessageReceived: (JavascriptMessage message) {
          print(message.message);
        }),
  ].toSet();

  final flutterWebViewPlugin = FlutterWebviewPlugin();


  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Hextris game'),
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
