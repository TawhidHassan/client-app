
// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';
part 'User.g.dart';

@JsonSerializable()
class User{
  @JsonKey(name: "_id")
  int id;

  String name;
  String lan;
  String email;
  String lat;


  User(this.id, this.name, this.lan, this.email,
      this.lat);

  factory User.fromJson(Map<String,dynamic>json)=>
      _$UserFromJson(json);
  Map<String,dynamic>toJson()=>_$UserToJson(this);
}