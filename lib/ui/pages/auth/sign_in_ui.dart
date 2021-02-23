import 'package:fire_chat/core/controllers/controllers.dart';
import 'package:fire_chat/core/helpers/helpers.dart';
import 'package:fire_chat/localizations.dart';
import 'package:fire_chat/ui/components/components.dart';
import 'package:fire_chat/ui/pages/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';

class SignInUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final plugin = FacebookLogin(debug: true);

  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return Scaffold(
      body: buildForm(labels, context),
    );
  }

  Form buildForm(AppLocalizations_Labels labels, BuildContext context) {
    return Form(
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
                FormInputFieldWithIcon(
                  controller: authController.passwordController.value,
                  iconPrefix: Icons.lock,
                  labelText: labels?.auth?.passwordFormField,
                  validator: Validator(labels).password,
                  obscureText: true,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                      authController.passwordController.value.text = value,
                  maxLines: 1,
                ),
                FormVerticalSpace(),
                PrimaryButton(
                    labelText: labels?.auth?.signInButton,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        authController.signInWithEmailAndPassword(context);
                      }
                    }),
                FormVerticalSpace(),
                Wrap(
                  runAlignment: WrapAlignment.center,
                  runSpacing: 8.0,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    GoogleSignInButton(
                      labelText: labels?.auth?.googleSignInButton,
                      onPressed: () async {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        authController.googleSignIn(context);
                      },
                    ),
                    FacebookSignInButton(
                      labelText: labels?.auth?.googleSignInButton,
                      onPressed: () async {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        authController.facebookSignIn(context);
                      },
                      onLongPressed: () =>
                          Get.offAll(() => LoginSelectorUi(plugin: plugin)),
                    ),
                    TwitterSignInButton(
                      labelText: labels?.auth?.googleSignInButton,
                      onPressed: () async {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        authController.twitterSignIn(context);
                      },
                    ),
                  ],
                ),
                FormVerticalSpace(),
                LabelButton(
                  labelText: labels?.auth?.resetPasswordLabelButton,
                  onPressed: () => Get.to(() => ResetPasswordUI()),
                ),
                LabelButton(
                  labelText: labels?.auth?.signUpLabelButton,
                  onPressed: () => Get.offAll(() => SignUpUI()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
