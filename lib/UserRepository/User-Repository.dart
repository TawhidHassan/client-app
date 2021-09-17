// ignore: unused_import
// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:user_location_get_app/UserNetworkService/User-Service.dart';

class UserRepository {
  var logger = Logger();

  Future loginUser(String userid,String password) async {
    Map<String, String> data = {
      "email":userid,
      "password": password,
    };
    final userRaw=await UserNetwork().login(data);
    // logger.d(userRaw['success']);

    if (userRaw == null) return null;

    // Login login=Login.fromJson(userRaw);

    print(userRaw);
    return userRaw;
  }

  Future updateLanLot(String lan, String lot,String id) async{
    Map<String, String> data = {
      "lat":lan,
      "lon": lot,
    };
    final userRaw=await UserNetwork().updateLanLot(data,id);
    // logger.d(userRaw['success']);

    if (userRaw == null) return null;

    // Login login=Login.fromJson(userRaw);

    print(userRaw);
    return userRaw;
  }

}