
import 'package:fire_chat/core/controllers/controllers.dart';
import 'package:fire_chat/core/helpers/helpers.dart';
import 'package:fire_chat/core/models/models.dart';
import 'package:fire_chat/localizations.dart';
import 'package:fire_chat/ui/components/components.dart';
import 'package:fire_chat/ui/pages/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UpdateProfileUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    //print('user.name: ' + user?.value?.name);
    authController.nameController.value.text =
        authController?.firestoreUser?.value?.name;
    authController.emailController.value.text =
        authController?.firestoreUser?.value?.email;
    return Scaffold(
      appBar: AppBar(title: Text(labels.auth.updateProfileTitle)),
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
                    controller: authController.nameController.value,
                    iconPrefix: Icons.person,
                    labelText: labels.auth.nameFormField,
                    validator: Validator(labels).name,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                    authController.nameController.value.text = value,
                  ),
                  FormVerticalSpace(),
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
                      labelText: labels?.auth?.updateUser,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          UserModel _updatedUser = UserModel(
                              uid: authController?.firestoreUser?.value?.uid,
                              name: authController.nameController.value.text,
                              email: authController.emailController.value.text,
                              photoUrl: authController
                                  ?.firestoreUser?.value?.photoUrl);
                          _updateUserConfirm(context, _updatedUser,
                              authController?.firestoreUser?.value?.email);
                        }
                      }),
                  FormVerticalSpace(),
                  LabelButton(
                    labelText: labels?.auth?.resetPasswordLabelButton,
                    onPressed: () => Get.to(() => ResetPasswordUI()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _updateUserConfirm(
      BuildContext context, UserModel updatedUser, String oldEmail) async {
    final labels = AppLocalizations.of(context);
    final AuthController authController = AuthController.to;
    final TextEditingController _password = new TextEditingController();
    return Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      title: Text(
        labels.auth.enterPassword,
      ),
      content: FormInputFieldWithIcon(
        controller: _password,
        iconPrefix: Icons.lock,
        labelText: labels.auth.passwordFormField,
        validator: Validator(labels).password,
        obscureText: true,
        onChanged: (value) => null,
        onSaved: (value) => _password.text = value,
        maxLines: 1,
      ),
      actions: <Widget>[
        new TextButton(
          child: new Text(labels.auth.cancel.toUpperCase()),
          onPressed: () {
            Get.back();
          },
        ),
        new TextButton(
          child: new Text(labels.auth.submit.toUpperCase()),
          onPressed: () async {
            Get.back();
            await authController.updateUser(
                context, updatedUser, oldEmail, _password.text);
          },
        )
      ],
    ));
  }
}
