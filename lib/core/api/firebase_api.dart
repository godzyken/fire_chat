
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat/core/controllers/auth_controller.dart';
import 'package:fire_chat/core/helpers/helpers.dart';
import 'package:fire_chat/core/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseApi {

  static Stream<List<UserModel>> getUserModels() => FirebaseFirestore.instance
      .collection('users')
      .orderBy(UserModelField.lastActive, descending: true)
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

  //Method to load games
  static Future uploadGames(GameModel gameModel, String getUrl) async {
    final refGames =
    FirebaseFirestore.instance.collection('games/${gameModel.id}/game');

    final newGames = GameModel(
      id: gameModel.id,
      name: gameModel.name,
      url: getUrl,
    );
    await refGames.add(newGames.toJson());
  }

  static Stream<List<GameModel>> getGameModels() => FirebaseFirestore.instance
      .collection('games')
      .snapshots()
      .transform(Utils.transformer(GameModel.fromJson));

  static Future<String> uploadImage(String path, File file) async {
    final ref =
    FirebaseFirestore.instance
        .collection('users/$file/photoUrl');

    return ref.path;
  }

  static Future<bool> login() async {
    final googleUser = GoogleSignIn.standard(scopes: ['email']);
    if (googleUser == null) throw Exception('No user');

    final googleAuth = await googleUser.currentUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    final userCredential = await AuthController.to.firebaseUser.value.linkWithCredential(credential);

    return userCredential.additionalUserInfo.isNewUser;
  }

}
