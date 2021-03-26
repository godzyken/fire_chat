import 'package:fire_chat/core/helpers/helpers.dart';
import 'package:fire_chat/core/models/models.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat/stream_chat.dart';

class MessageModelField {
  static final String createdAt = 'createdAt';
}

class MessageModel {
  final String id;
  final Map<String, dynamic> extraData;
  final String message;
  final DateTime createdAt;
  final String text;
  final String type;
  final List<Attachment> attachments;
  final List<UserModel> mentionedUsers;
  final bool silent;
  final bool shadowed;
  final Map<String, int> reactionCounts;
  final Map<String, int> reactionScores;
  final List<Reaction> latestReactions;
  final List<Reaction> ownReactions;
  final String parentId;
  final MessageModel quotedMessage;
  final String quotedMessageId;
  final int replyCount;
  final List<UserModel> threadParticipants;
  final bool showInChannel;
  final String command;
  final DateTime updatedAt;
  final UserModel user;
  final bool pinned;
  final DateTime pinnedAt;
  final Object pinExpires;
  final UserModel pinnedBy;
  final DateTime deletedAt;
  final MessageSendingStatus status;

  const MessageModel({
    @required this.id,
    this.extraData,
    @required this.message,
    this.createdAt,
    @required this.text,
    this.type,
    this.attachments,
    this.mentionedUsers,
    this.silent,
    this.shadowed,
    this.reactionCounts,
    this.reactionScores,
    this.latestReactions,
    this.ownReactions,
    this.parentId,
    this.quotedMessage,
    this.quotedMessageId,
    this.replyCount,
    this.threadParticipants,
    this.showInChannel,
    this.command,
    this.updatedAt,
    @required this.user,
    this.pinned,
    this.pinnedAt,
    this.pinExpires,
    @required this.pinnedBy,
    this.deletedAt,
    this.status,
  });

  static MessageModel fromJson(Map<String, dynamic> json) => MessageModel(
    id: json['id'],
    extraData: json['extraData'],
    message: json['message'],
    type: json['type'],
    ownReactions: json['ownReactions'],
    quotedMessageId: json['quotedMessageId'],
    quotedMessage: json['quotedMessage'],
    user: json['user'],
    attachments: json['attachments'],
    text: json['text'],
    command: json['command'],
    mentionedUsers: json['mentionedUsers'],
    parentId: json['parentId'],
    pinned: json['pinned'],
    pinnedAt: json['pinnedAt'],
    pinnedBy: json['pinnedBy'],
    reactionCounts: json['reactionCounts'],
    reactionScores: json['reactionScores'],
    replyCount: json['replyCount'],
    shadowed: json['shadowed'],
    showInChannel: json['showInChannel'],
    silent: json['silent'],
    status: json['status'],
    threadParticipants: json['threadParticipants'],
    createdAt: Utils.toDateTime(json['createdAt']),
    updatedAt: Utils.toDateTime(json['updatedAt']),
    deletedAt: Utils.toDateTime(json['deletedAt']),
    latestReactions: json['lastReactions'],
    pinExpires: Utils.toDateTime(json['pinExpires']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'extraData': extraData,
    'user': user,
    'message': message,
    'text': text,
    'type': type,
    'pinned': pinned,
    'pinnedBy': type,
    'attachments': attachments,
    'mentionedUsers': mentionedUsers,
    'reactionCounts': reactionCounts,
    'reactionScores': reactionScores,
    'ownReactions': ownReactions,
    'parentId': parentId,
    'quotedMessage': quotedMessage,
    'quotedMessageId': quotedMessageId,
    'replyCount': replyCount,
    'showInChannel': showInChannel,
    'shadowed': shadowed,
    'silent': silent,
    'command': command,
    'threadParticipants': threadParticipants,
    'createdAt': Utils.fromDateTimeToJson(createdAt),
    'updatedAt': Utils.fromDateTimeToJson(updatedAt),
    'deletedAt': Utils.fromDateTimeToJson(deletedAt),
    'latestReactions': latestReactions,
    'pinnedAt': Utils.fromDateTimeToJson(pinnedAt),
    'pinExpires': Utils.fromDateTimeToJson(pinExpires),
  };
}