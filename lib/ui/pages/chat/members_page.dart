import 'package:fire_chat/core/api/api.dart';
import 'package:fire_chat/core/models/models.dart';
import 'package:fire_chat/ui/pages/chat/chat.dart';
import 'package:fire_chat/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' hide User;

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

    allUsers = StreamUserApi.getAllUsers();
  }

  @override
  Widget build(BuildContext context) => StreamChat(
      client: StreamApi.client,
      child: Scaffold(
        appBar: AppBar(
          primary: true,
          centerTitle: true,
          backwardsCompatibility: true,
          leading: BackButton(
            color: Colors.white,
            onPressed: () => Get.offAll(() => ChatsPage()),
          ),
          title: Text('Add Participants'),
          actions: [
            TextButton(
              child: Text('CREATE', style: TextStyle(color: Colors.black)),
              onPressed: selectUsers.isEmpty
                  ? null
                  : () =>
                      Get.offAll(() =>  StreamChat(client: StreamApi.client,
                          child: CreateChannelPage(members: selectUsers))),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: FutureBuilder<List<UserModel>>(
          future: allUsers,
          builder: (context, snapshot) {
            switch (snapshot?.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  print('error @@@@@ $snapshot');
                  return Center(child: Text('Something Went Wrong Try later'));
                } else {
                  final users = snapshot.data
                      .where((UserModel user) =>
                          user?.uid != StreamChat.of(context)?.user?.id)
                      .toList();

                  return buildUsers(users);
                }
            }
          },
        ),
      ));

  Widget buildUsers(List<UserModel> users) => ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          print('@@@@ ${user.name}');
          return CheckboxListTile(
            value: selectUsers?.contains(user),
            onChanged: (isAdded) => setState(() =>
                isAdded ? selectUsers.add(user) : selectUsers.remove(user)),
            title: Row(
              children: [
                ProfileImageWidget(imageUrl: user?.photoUrl),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    user?.name,
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
