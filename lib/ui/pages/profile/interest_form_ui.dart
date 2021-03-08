import 'package:fire_chat/core/controllers/controllers.dart';
import 'package:fire_chat/core/helpers/helpers.dart';
import 'package:fire_chat/localizations.dart';
import 'package:fire_chat/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class InterestFormUi extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
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
                Avatar(authController.firestoreUser.value),
                SizedBox(height: 48.0),
                FormInputFieldWithIcon(
                  controller: authController.interestController.value,
                  iconPrefix: Icons.link_sharp,
                  labelText: labels?.auth?.nameFormField,
                  validator: Validator(labels).name,
                  keyboardType: TextInputType.name,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                  authController.interestController.value.text = value,
                ),
                FormVerticalSpace(),
                FormInputFieldWithIcon(
                  controller: authController.interestController.value,
                  iconPrefix: Icons.link_sharp,
                  labelText: labels?.auth?.nameFormField,
                  validator: Validator(labels).name,
                  keyboardType: TextInputType.name,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                  authController.interestController.value.text = value,
                ),
                FormVerticalSpace(),
                FormInputFieldWithIcon(
                  controller: authController.interestController.value,
                  iconPrefix: Icons.link_sharp,
                  labelText: labels?.auth?.nameFormField,
                  validator: Validator(labels).name,
                  keyboardType: TextInputType.name,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                  authController.interestController.value.text = value,
                ),
                FormVerticalSpace(),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
