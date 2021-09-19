
// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';
part 'User.g.dart';

@JsonSerializable()
class User{

  String lat;
  String lon;
  @JsonKey(name: "_id")
  String id;
  String email;
  String name;


  User(this.lat, this.lon, this.id, this.email, this.name);

  factory User.fromJson(Map<String,dynamic>json)=>
      _$UserFromJson(json);
  Map<String,dynamic>toJson()=>_$UserToJson(this);
}