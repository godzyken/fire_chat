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
  final bool isOnline;
  final bool isAdmin;

  UserModel({
    @required this.uid,
    this.interest,
    @required this.email,
    @required this.name,
    @required this.photoUrl,
    this.lastMessageTime,
    this.isOnline,
    this.isAdmin,
  });

  UserModel copyWith({
    String uid,
    String email,
    String name,
    String photoUrl,
    String lastMessageTime,
    String isOnline,
    String inAdmin,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        name: name ?? this.name,
        photoUrl: photoUrl ?? this.photoUrl,
        lastMessageTime: lastMessageTime ?? this.lastMessageTime,
        interest: interest ?? this.interest,
        isOnline: isOnline ?? this.isOnline,
        isAdmin: isAdmin ?? this.isAdmin,
      );

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        name: json['name'],
        email: json['email'],
        photoUrl: json['photoUrl'],
        interest: json['interest'],
        isOnline: json['isOnline'],
        isAdmin: json['isAdmin'],
        lastMessageTime: Utils.toDateTime(json['lastMessageTime']),
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'name': name,
        'photoUrl': photoUrl,
        'interest': interest,
        'isOnline': isOnline,
        'isAdmin': isAdmin,
        'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime)
      };

  int get hashCode => uid.hashCode ^ name.hashCode ^ photoUrl.hashCode;

  bool operator ==(other) =>
      other is UserModel &&
      other.name == name &&
      other.photoUrl == photoUrl &&
      other.uid == uid;
}
