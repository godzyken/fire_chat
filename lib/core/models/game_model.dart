import 'package:get/get.dart';

class RxGameModel {
  final id = 0.obs;
  final name = 'name'.obs;
  final url = 'url'.obs;
}

class GameModel {
  GameModel({id, name, url});

  final rx = RxGameModel();

  get url => rx.url.value;
  set url(value) => rx.url.value = value;

  get name => rx.name.value;
  set name(value) => rx.name.value = value;

  get id => rx.id.value;
  set id(value) => rx.id.value = value;

  static GameModel fromJson(Map<String, dynamic> json) => GameModel(
    id: json['id'],
    name: json['name'],
    url: json['url'],
  );

  Map<String, dynamic> toJson() => {
    'url': url, 'name' : name, 'id':id,
  };
}
