
import 'dart:io';
import 'package:fire_chat/ui/interfaces/interfaces.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';


class LoginSelectorUi extends StatefulWidget {
  final FacebookLogin plugin;

  const LoginSelectorUi({Key key, @required this.plugin}) : assert(plugin != null), super(key: key);

  @override
  _LoginSelectorUiState createState() => _LoginSelectorUiState();
}

class _LoginSelectorUiState extends State<LoginSelectorUi> {
  String _sdkVersion;
  FacebookAccessToken _token;
  FacebookUserProfile _profile;
  String _email;
  String _imageUrl;

  @override
  void initState() {
    super.initState();

    _getSdkVersion();
    _updateLoginInfo();
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = _token != null && _profile != null;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login via Facebook example'),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              if (_sdkVersion != null) Text('SDK v$_sdkVersion'),
              if (isLogin)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _buildUserInfo(context, _profile, _token, _email),
                ),
              isLogin
                  ? OutlinedButton(
                child: const Text('Log Out'),
                onPressed: _onPressedLogOutButton,
              )
                  : OutlinedButton(
                child: const Text('Log In'),
                onPressed: _onPressedLogInButton,
              ),
              if (!isLogin && Platform.isAndroid)
                OutlinedButton(
                  child: const Text('Express Log In'),
                  onPressed: () => _onPressedExpressLogInButton(context),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context, FacebookUserProfile profile,
      FacebookAccessToken accessToken, String email) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_imageUrl != null)
          Center(
            child: Image.network(_imageUrl),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text('User: '),
            Text(
              '${profile.firstName} ${profile.lastName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Text('AccessToken: '),
        Text(
          accessToken.token,
          softWrap: true,
        ),
        if (email != null) Text('Email: $email'),
      ],
    );
  }

  Future<void> _onPressedLogInButton() async {
    await widget.plugin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    await _updateLoginInfo().then((value) => Get.offAll(() => HomeUI()));
  }

  Future<void> _onPressedExpressLogInButton(BuildContext context) async {
    final res = await widget.plugin.expressLogin();
    if (res.status == FacebookLoginStatus.success) {
      await _updateLoginInfo();
    } else {
      await showDialog<Object>(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text("Can't make express log in. Try regular log in."),
        ),
      );
    }
  }

  Future<void> _onPressedLogOutButton() async {
    await widget.plugin.logOut();
    await _updateLoginInfo();
  }

  Future<void> _getSdkVersion() async {
    final sdkVesion = await widget.plugin.sdkVersion;
    setState(() {
      _sdkVersion = sdkVesion;
    });
  }

  Future<void> _updateLoginInfo() async {
    final plugin = widget.plugin;
    final token = await plugin.accessToken;
    FacebookUserProfile profile;
    String email;
    String imageUrl;

    if (token != null) {
      profile = await plugin.getUserProfile();
      if (token.permissions?.contains(FacebookPermission.email.name) ?? false) {
        email = await plugin.getUserEmail();
      }
      imageUrl = await plugin.getProfileImageUrl(width: 100);
    }

    setState(() {
      _token = token;
      _profile = profile;
      _email = email;
      _imageUrl = imageUrl;
    });
  }
}
