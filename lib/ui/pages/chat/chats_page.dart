import 'package:fire_chat/core/api/api.dart';
import 'package:fire_chat/core/constants/constants.dart';
import 'package:fire_chat/core/models/models.dart';
import 'package:fire_chat/ui/ui.dart';
import 'package:fire_chat/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatsPage extends StatefulWidget {
  @override
  _ChatsPageState createState() => _ChatsPageState();
}


class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: GestureDetector(
            onDoubleTap: () {
              print("DOUBLE TAB");
              Get.off(() => DashboardWidget());
            },
            onTap: () {},
            behavior: HitTestBehavior.translucent,
            child: StreamBuilder<List<UserModel>>(
              stream: FirebaseApi.getUserModels(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return buildText('Something Went Wrong Try later');
                    } else {
                      final users = snapshot.data;
                      if (users.isEmpty) {
                        return buildText('No Users Found');
                      } else
                        return Column(
                          children: [
                            ChatHeaderWidget(users: users),
                            // ChatBodyWidget(users: users),
                            Expanded(
                                child: StreamChat(
                                    client: StreamApi.client,
                                    streamChatThemeData:
                                        StreamChatThemeData.getDefaultTheme(
                                            AppThemes.darkTheme
                                        ),
                                    child: ChannelsBloc(
                                        child: ChatsWidget()
                                    ),
                                )
                            ),
                            Divider(),
                            Container(
                              height: 100,
                              child: ActiveUsersRowWidget(),
                            ),
                            Divider(),
                          ],
                        );
                    }
                }
              },
            ),
          ),
        ),
      );

  Widget buildText(String text) =>
      Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      );
}

