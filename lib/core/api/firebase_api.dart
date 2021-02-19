
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat/core/helpers/helpers.dart';
import 'package:fire_chat/core/models/models.dart';

class FirebaseApi {
  static Stream<List<UserModel>> getUserModels() => FirebaseFirestore.instance
      .collection('users')
      .orderBy(UserModelField.lastMessageTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(UserModel.fromJson));

  static Future uploadMessage(UserModel idUser, String message) async {
    final refMessages =
    FirebaseFirestore.instance.collection('chats/${idUser.uid}/messages');

    final newMessage = Message(
      idUser: idUser.uid,
      urlAvatar: idUser.photoUrl,
      username: idUser.name,
      message: message,
      createdAt: DateTime.now(),
    );
                                                                                                                                                                                                                                                                                 await refMessages.add(newMessage.toJson());

    final refUsers = FirebaseFirestore.instance.collection('users');
    await refUsers
        .doc(newMessage.idUser)
        .update({UserModelField.lastMessageTime: DateTime.now()});
  }

  static Stream<List<Message>> getMessages(UserModel idUser) =>
      FirebaseFirestore.instance
          .collection('chats/${idUser.uid}/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));

  static Future uploadChannel(UserModel idUser, Message message, String channel) async {
    final refChannels =
    FirebaseFirestore.instance.collection('channels/${idUser.uid}/chats');

    final newChannel = ChannelModel(
      id: idUser.uid,
      t: channel,
      name: idUser.name,
      usernames: []..length,
      user: idUser,
      msgs: message,
      ts: DateTime.now(),
    );
    await refChannels.add(newChannel.toJson());

    final refUsers = FirebaseFirestore.instance.collection('users');
    await refUsers
        .doc(newChannel.id)
        .update({UserModelField.lastMessageTime: DateTime.now()});
  }

  static Stream<List<ChannelModel>> getChannelModels(UserModel idUser) =>
      FirebaseFirestore.instance
          .collection('channels/${idUser.uid}/chats')
          .orderBy(ChannelModelField.ts, descending: true)
          .snapshots()
          .transform(Utils.transformer(ChannelModel.fromJson));

}