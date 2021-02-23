
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat/core/helpers/helpers.dart';
import 'package:fire_chat/core/models/models.dart';
import 'package:get/get.dart';

class FirebaseApi {
  static Stream<List<UserModel>> getUserModels() => FirebaseFirestore.instance
      .collection('users')
      .orderBy(UserModelField.lastMessageTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(UserModel.fromJson));

  static Future uploadMessage(UserModel userModel, String message) async {
    final refMessages =
        FirebaseFirestore.instance.collection('chats/${userModel.uid}/messages');


    final newMessage = Message(
      idUser: userModel.uid,
      urlAvatar: userModel.photoUrl,
      username: userModel.name,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());

  }

  static Stream<List<Message>> getMessages(String idUser) =>
      FirebaseFirestore.instance
          .collection('chats/$idUser/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));

  static Future uploadChannels(String idUser, String channel) async {
    final refChannels =
        FirebaseFirestore.instance.collection('channels/$idUser/chats');

    final UserModel userModel = Get.find();
    final Message message = Get.find();
    final HobbiesModel hobbies = Get.find();

    final newChannel = ChannelModel(
      id: idUser,
      t: message.idUser,
      name: channel,
      usernames: []..length,
      user: userModel,
      msgs: message,
      hobbies: hobbies,
      ts: DateTime.now(),
    );
    await refChannels.add(newChannel.toJson());

  }

  static Future uploadChannel(String idUser) async {
    final refChannels =
        FirebaseFirestore.instance.collection('channels/$idUser/chats');

    final UserModel userModel = Get.find();
    final Message message = Get.find();
    final HobbiesModel hobbies = Get.find();

    final newChannel = ChannelModel(
      id: idUser,
      t: message.idUser,
      name: refChannels.path,
      usernames: []..length,
      user: userModel,
      msgs: message,
      hobbies: hobbies,
      ts: DateTime.now(),
    );
    await refChannels.add(newChannel.toJson());

  }

  static Stream<List<ChannelModel>> getChannelModels() =>
      FirebaseFirestore.instance
          .collection('channels')
          .orderBy(ChannelModelField.ts, descending: true)
          .snapshots()
          .transform(Utils.transformer(ChannelModel.fromJson));

}
