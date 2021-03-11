import 'package:fire_chat/core/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) => controller?.firestoreUser?.value?.uid == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(controller.firestoreUser.value.photoUrl),
                          radius: 50,
                        ),
                        SizedBox(height: 20),
                        Text(
                          controller.firestoreUser.value.name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          child: Text('Logout'),
                          onPressed: () {
                            AuthController.to.signOut();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ));
  }
}
