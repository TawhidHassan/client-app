// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['lat'] as String,
    json['lon'] as String,
    json['_id'] as String,
    json['email'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
      '_id': instance.id,
      'email': instance.email,
      'name': instance.name,
    };
