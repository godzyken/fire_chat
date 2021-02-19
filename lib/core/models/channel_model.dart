import 'package:fire_chat/core/helpers/helpers.dart';
import 'package:fire_chat/core/models/models.dart';
import 'package:flutter/foundation.dart';

class ChannelModelField {
  static final String ts = 'lastChannelTime';
}

class ChannelModel {
  final String id;
  final String name;
  final String t;
  final List<String> usernames;
  final Message msgs;
  final UserModel user;
  final DateTime ts;

  ChannelModel(
      {@required this.t,
      @required this.usernames,
      @required this.msgs,
      @required this.user,
      @required this.ts,
      this.id,
      @required this.name});

  ChannelModel copyWith({
    final String id,
    final String name,
    final String t,
    final List<String> usernames,
    final Message msgs,
    final UserModel user,
    final DateTime ts,
  }) =>
      ChannelModel(
        id: id ?? this.id,
        name: name ?? this.name,
        t: t ?? this.t,
        usernames: usernames ?? this.usernames,
        msgs: msgs ?? this.msgs,
        user: user ?? this.user,
        ts: ts ?? this.ts,
      );

  static ChannelModel fromJson(Map<String, dynamic> json) => ChannelModel(
    id: json['id'],
    name: json['name'],
    t: json['t'],
    user: json['user'],
    usernames: json['usernames'],
    msgs: json['messages'],
    ts: Utils.toDateTime(json['lastMessageTime']),
  );

  Map<String, dynamic> toJson() =>
      {'id': id, 't': t, 'name': name, 'user': user, 'usernames': usernames, 'messages': msgs, 'lastMessageTime': Utils.fromDateTimeToJson(ts)};
}
