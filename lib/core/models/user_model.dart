import 'package:fire_chat/core/helpers/helpers.dart';
import 'package:flutter/cupertino.dart';

class UserModelField {
  static final String lastMessageTime = 'lastMessageTime';
}

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String photoUrl;
  final DateTime lastMessageTime;
  final String interest;

  UserModel({
    this.uid,
    this.interest,
    @required this.email,
    @required this.name,
    @required this.photoUrl,
    @required this.lastMessageTime});


  UserModel copyWith({
    String uid,
    String email,
    String name,
    String photoUrl,
    String lastMessageTime,
  }) => UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      interest: interest ?? this.interest,
    );

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
    uid: json['uid'],
    name: json['name'],
    email: json['email'],
    photoUrl: json['photoUrl'],
    interest: json['interest'],
    lastMessageTime: Utils.toDateTime(json['lastMessageTime']),
  );

  Map<String, dynamic> toJson() =>
      {'uid': uid, 'email': email, 'name': name, 'photoUrl': photoUrl, 'interest': interest, 'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime)};
}