
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_location_get_app/Constants/Strings/appStrings.dart';
import 'package:user_location_get_app/Presentation/Page/Home/HomePage.dart';
import 'package:user_location_get_app/Presentation/Screens/splash_screen.dart';
import 'package:user_location_get_app/User/user_cubit.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments as Map;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case HOME_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider(
              create: (context) => UserCubit(),
              child: HomePage(),
            ));

      default:
        return null;
    }
  }
}
