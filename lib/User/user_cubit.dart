import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:user_location_get_app/Model/Login/Login.dart';
import 'package:user_location_get_app/UserRepository/User-Repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  var logger = Logger();
  UserCubit() : super(UserInitial());
  Login valuex;
  void logIn(String email, String password) {
    UserRepository().loginUser(email, password).then((value) => {
      logger.d(value),
      if(value['message']!="The given data was invalid."){
        logger.d(value),
        // logger.d(value.token),
        valuex= Login.fromJson(value),
        emit(LoginSuccessful(login: valuex))
      }else{
        emit(LoginSuccessful(login: null))
      }

    });
  }

  void updateLanLot(String lan, String lot,String id ) {
    UserRepository().updateLanLot(lan, lot,id).then((value) => {

      if(value!=null){
        logger.d(value),
        emit(Updated(update: "update"))
      }else{
        emit(Updated(update: "none"))
      }

    });
  }
}
