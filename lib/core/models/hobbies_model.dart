class HobbiesModel {

  int id;
  String name;
  Activities activities;


  HobbiesModel({ this.id, this.name, this.activities });

  HobbiesModel.fromJson(Map<String, dynamic> json){
      this.id = json['id'];
      this.name = json['name'];
      this.activities = json['activities'];
  }

  Map<String, dynamic> toJson() => {'id':id, 'name':name, 'activities': activities };
}

class Activities {
  int id;
  String name;

  Activities({this.id, this.name});

  Activities.fromJson(Map<String, dynamic> json){
    this.id = json['id'];
    this.name = json['name'];
  }

  Map<String, dynamic> toJson() => {'id':id, 'name':name };

}