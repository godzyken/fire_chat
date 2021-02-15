import 'dart:convert';
import 'package:fire_chat/core/helpers/helpers.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModelField {
  static final String lastMessageTime = 'lastMessageTime';
}

class UserModel {
  String uid;
  String email;
  String name;
  String photoUrl;
  DateTime lastMessageTime;

  UserModel({this.uid, this.email, this.name, this.photoUrl, this.lastMessageTime});

  static UserModel fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  static UserModel fromJson2(Map<String, dynamic> json) => UserModel(
    uid: json['uid'],
    name: json['name'],
    email: json['email'],
    photoUrl: json['photoUrl'],
    lastMessageTime: Utils.toDateTime(json['lastMessageTime']),
  );

  UserModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    uid = documentSnapshot.id;
    name = documentSnapshot["name"];
    email = documentSnapshot["email"];
    photoUrl = documentSnapshot["photoUrl"];
    lastMessageTime = documentSnapshot["lastMessageTime"];
  }

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      lastMessageTime: Utils.toDateTime(data['lastMessageTime'] ?? ''),
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    uid: json["Uid"] == null ? null : json["Uid"] as String,
    name: json["Name"] == null ? null : json["Name"] as String,
    email: json["Email"] == null ? null : json["Email"] as String,
    photoUrl: json["PhotoUrl"] == null ? null : json["PhotoUrl"] as String,
    lastMessageTime: json["LastMessageTime"] == null ? null : json["LastMessageTime"] as DateTime,
  );

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> map = snap.data();
    if (map.containsKey('name')) {
      return UserModel.fromMap(
        map,
      );
    }
    return UserModel(
      uid: snap.id,
      name: snap.reference.path,
      email: snap.reference.path,
      photoUrl: snap.reference.path,
      lastMessageTime: Utils.toDateTime(snap.data()['lastMessageTime']),
    );
  }

  Map<String, dynamic> toJson() =>
      {"uid": uid, "email": email, "name": name, "photoUrl": photoUrl, "lastMessageTime": Utils.fromDateTimeToJson(lastMessageTime)};
}