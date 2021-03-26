import 'dart:io';

import 'package:fire_chat/core/api/api.dart';
import 'package:fire_chat/core/models/models.dart';
import 'package:fire_chat/ui/interfaces/home_ui.dart';
import 'package:fire_chat/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateRoomPage extends StatefulWidget {
  final List<UserModel> participants;

  const CreateRoomPage({
    Key key,
    @required this.participants,
  }) : super(key: key);

  @override
  _CreateRoomPageState createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  String name = '';
  File imageFile;
  final picker = ImagePicker();

  int tabIndex;

  Future getImage() async {
    PickedFile pickedFile =
    await picker.getImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    setState(() {
      imageFile = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Create Room'),
          actions: [
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () async {
                final idParticipants = widget.participants
                    .map((participant) => participant.uid)
                    .toList();

                await StreamChannelApi.createChannel(
                  context,
                  name: name,
                  imageFile: imageFile,
                  idMembers: idParticipants,
                );

                Get.offAll((context) => HomeUI(tabIndex: tabIndex));
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(24),
          children: [
            GestureDetector(
              onTap: () async {
                await getImage();
              },
              child: buildImage(context),
            ),
            const SizedBox(height: 48),
            buildTextField(),
            const SizedBox(height: 12),
            Text(
              'Participants',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 12),
            buildMembers(),
          ],
        ),
      );

  Widget buildImage(BuildContext context) {
    if (imageFile == null) {
      return CircleAvatar(
        radius: 64,
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(Icons.add, color: Colors.white, size: 64),
      );
    } else {
      return CircleAvatar(
        radius: 64,
        backgroundColor: Theme.of(context).accentColor,
        child: ClipOval(
          child: Image.file(imageFile,
              fit: BoxFit.cover,
              width: 128,
              height: 128,
              errorBuilder: (context, error, stackTrace) {
            return Container(height: 100, width: 100, color: Colors.red);
          }),
        ),
      );
    }
  }

  Widget buildTextField() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Channel Name',
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
        ),
        maxLength: 30,
        onChanged: (value) => setState(() => name = value),
      );

  Widget buildMembers() => Column(
        children: widget.participants
            .map((member) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: ProfileImageWidget(imageUrl: member.photoUrl),
                  title: Text(
                    member.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
      );
}
