import 'package:fire_chat/core/api/api.dart';
import 'package:fire_chat/core/models/models.dart';
import 'package:fire_chat/ui/pages/chat/chat.dart';
import 'package:fire_chat/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class MembersPage extends StatefulWidget {
  @override
  _MembersPageState createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  Future<List<UserModel>> allUsers;
  List<UserModel> selectUsers = [];

  @override
  void initState() {
    super.initState();

    allUsers = StreamUserApi.getAllUser();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          primary: true,
          centerTitle: true,
          backwardsCompatibility: true,
          title: Text('Add Participants'),
          actions: [
            BackButton(
              color: Colors.white,
              onPressed: () => Get.off(() => ChatsPage()),
            ),
            TextButton(
              child: Text('CREATE'),
              onPressed: selectUsers.isEmpty
                  ? null
                  : () =>
                      Get.offAll(() => CreateChannelPage(members: selectUsers)),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: FutureBuilder<List<UserModel>>(
          future: allUsers,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Something Went Wrong Try later'));
                } else {
                  final users = snapshot.data
                      .where((UserModel user) =>
                          user.uid != StreamChat.of(context).user.id)
                      .toList();

                  return buildUsers(users);
                }
            }
          },
        ),
      );

  Widget buildUsers(List<UserModel> users) => ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          return CheckboxListTile(
            value: selectUsers.contains(user),
            onChanged: (isAdded) => setState(() =>
                isAdded ? selectUsers.add(user) : selectUsers.remove(user)),
            title: Row(
              children: [
                ProfileImageWidget(imageUrl: user.photoUrl),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    user.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      );
}
