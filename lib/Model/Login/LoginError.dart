
// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

part 'LoginError.g.dart';

@JsonSerializable()
class LoginError{

  String message;


  LoginError(this.message);

  factory LoginError.fromJson(Map<String,dynamic>json)=>
      _$LoginErrorFromJson(json);
  Map<String,dynamic>toJson()=>_$LoginErrorToJson(this);
}