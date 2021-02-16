import 'package:fire_chat/core/controllers/controllers.dart';
import 'package:fire_chat/core/helpers/helpers.dart';
import 'package:fire_chat/localizations.dart';
import 'package:fire_chat/ui/components/components.dart';
import 'package:fire_chat/ui/pages/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return Scaffold(
      appBar: appBar(context),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  LogoGraphicHeader(),
                  SizedBox(height: 48.0),
                  FormInputFieldWithIcon(
                    controller: authController.emailController.value,
                    iconPrefix: Icons.email,
                    labelText: labels?.auth?.emailFormField,
                    validator: Validator(labels).email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                    authController.emailController.value.text = value,
                  ),
                  FormVerticalSpace(),
                  PrimaryButton(
                      labelText: labels?.auth?.resetPasswordButton,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await authController.sendPasswordResetEmail(context);
                        }
                      }),
                  FormVerticalSpace(),
                  signInLink(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  appBar(BuildContext context) {
    final labels = AppLocalizations.of(context);
    if ((authController.emailController.value.text == '') ||
        (authController.emailController.value.text == null)) {
      return null;
    }
    return AppBar(title: Text(labels?.auth?.resetPasswordTitle));
  }

  signInLink(BuildContext context) {
    final labels = AppLocalizations.of(context);
    if ((authController.emailController.value.text == '') ||
        (authController.emailController.value.text == null)) {
      return LabelButton(
        labelText: labels?.auth?.signInonResetPasswordLabelButton,
        onPressed: () => Get.to(() => SignInUI()),
      );
    }
    return Container(width: 0, height: 0);
  }
}
