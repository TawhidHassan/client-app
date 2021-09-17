part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class LoginSuccessful extends UserState {
  final Login login;
  LoginSuccessful({this.login});
}

class Updated extends UserState {
  final String update;
  Updated({this.update});
}