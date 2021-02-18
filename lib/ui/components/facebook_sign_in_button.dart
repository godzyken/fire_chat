
import 'package:flutter/material.dart';

class FacebookSignInButton extends StatelessWidget {
  FacebookSignInButton({this.labelText, this.onPressed, this.isExpress});

  final String labelText;
  final void Function() onPressed;
  final bool isExpress;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.lightBlue,
          side: BorderSide(color: Colors.grey, width: 2),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("assets/img/facebook_logo.png"),
                  height: 35.0),
              Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    labelText.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
              )
            ],
          ),
        )
    );
  }
}