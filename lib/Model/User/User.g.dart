// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['_id'] as int,
    json['name'] as String,
    json['lan'] as String,
    json['email'] as String,
    json['lat'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'lan': instance.lan,
      'email': instance.email,
      'lat': instance.lat,
    };
