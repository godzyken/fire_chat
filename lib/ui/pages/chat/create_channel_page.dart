import 'dart:io';

import 'package:fire_chat/core/api/api.dart';
import 'package:fire_chat/core/models/models.dart';
import 'package:fire_chat/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateChannelPage extends StatefulWidget {
  final List<UserModel> members;

  const CreateChannelPage({Key key, @required this.members}) : super(key: key);

  @override
  _CreateChannelPageState createState() => _CreateChannelPageState();
}

class _CreateChannelPageState extends State<CreateChannelPage> {
  String name = '';
  File imageFile;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Create Room'),
          actions: [
            IconButton(
                icon: Icon(Icons.arrow_back_sharp),
                onPressed: () => Get.off(() => ChannelListWidget)),
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () async {
                final idParticipants = widget.members
                    .map((participant) => participant.uid)
                    .toList();

                await StreamChannelApi.createChannel(
                  context,
                  name: name,
                  imageFile: imageFile,
                  idMembers: idParticipants,
                );

                GetBuilder(builder: (context) => ChatHomePage());
              },
            ),
            const SizedBox(width: 8),
          ],
          primary: true,
          centerTitle: true,
          backwardsCompatibility: true,
          automaticallyImplyLeading: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(24),
          children: [
            GestureDetector(
              onTap: () async {
                final pickedFile =
                    await ImagePicker().getImage(source: ImageSource.gallery);

                if (pickedFile == null) return;

                setState(() {
                  imageFile = File(pickedFile.path);
                });
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
          child:
              Image.file(imageFile, fit: BoxFit.cover, width: 128, height: 128),
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
      onFieldSubmitted: (value) => setState(() =>
          StreamChannelApi.createChannel(context,
              name: value, imageFile: imageFile)));

  Widget buildMembers() => Column(
        children: widget.members
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
