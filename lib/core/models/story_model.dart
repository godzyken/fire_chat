
import 'package:fire_chat/core/helpers/helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class RxStoryModel {
  final imageUrl = ''.obs;
  final time = 'time'.obs;
}

class StoryModel {
  StoryModel({
    @required String imageUrl, @required DateTime time});

  final rx = RxStoryModel();

  get time => rx.time.value;
  set time(value) => rx.time.value = value;

  get imageUrl => rx.imageUrl.value;
  set imageUrl(value) => rx.imageUrl.value = value;

  StoryModel copy({
    String imageUrl,
    DateTime time,
  }) =>
      StoryModel(
        imageUrl: imageUrl ?? this.imageUrl,
        time: time ?? this.time,
      );

  static StoryModel fromJson(Map<String, dynamic> json) => StoryModel(
    imageUrl: json['imageUrl'],
    time: Utils.toDateTime(json['time']),
  );

  Map<String, dynamic> toJson() => {
    'time' : Utils.fromDateTimeToJson(time), 'imageUrl':imageUrl,
  };
}
