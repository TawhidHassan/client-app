// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_button/progress_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:hive/hive.dart';
import 'package:user_location_get_app/Presentation/Background/background.dart';
import 'package:user_location_get_app/Presentation/Widgets/Button/ProgressAnimatedButton.dart';
import 'package:user_location_get_app/Presentation/Widgets/TextField/NormalTextField.dart';
import 'package:user_location_get_app/Presentation/Widgets/TextField/PasswordField.dart';
import 'package:user_location_get_app/User/user_cubit.dart';

import '../MainScreen.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emilController=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();
  final _globalkey = GlobalKey<FormState>();
  bool circule;
  bool validate;
  ButtonState progressButtonState = ButtonState.normal;
  String name;
  Box users;
  Box usersx;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    users =Hive.box('users');

  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Hive.box("userData").close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if(state is LoginSuccessful){
            final data =(state as LoginSuccessful).login;
            if(data==null){
              AwesomeDialog(
                  context: context,
                  dialogType: DialogType.WARNING,
                  headerAnimationLoop: false,
                  animType: AnimType.TOPSLIDE,
                  title: 'Warning',
                  desc: 'Are you credentials wrong',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {})
                  .show();
              setState(() {
                progressButtonState = ButtonState.normal;
              });
            }else{

              storeToken(data.token,data.user.id, data.user.name, data.user.lon, data.user.email, data.user.lat);
              Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new MainScreen()));
            }
          }
        },
        child: Background(
          child: SingleChildScrollView(
            child: Form(
              key: _globalkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    height: 250,
                    child: Lottie.asset('assets/lottie/loginLotti.json'),
                  ),
                  Text(name??"Login",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text("Login to your account",
                    style: TextStyle(
                        fontSize: 15,
                        color:Colors.grey[700]),),
                  NormalInputField(controller:emilController ,hintText: "Enter Your Email",icon: Icons.alternate_email,),
                  SizedBox(height: 10,),
                  PasswordTextField(label: "Password",controller: passwordController,),

                  ProgressAnimatedButton(text: "Login",colors: Colors.redAccent,progressButtonState: progressButtonState,tap: (){
                    if (_globalkey.currentState.validate()) {
                      setState(() {
                        validate = true;
                        progressButtonState = ButtonState.inProgress;
                      });
                      print(emilController.text);
                      BlocProvider.of<UserCubit>(context).logIn(emilController.text,passwordController.text);

                    }

                  },)

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future storeToken(String token,String id,String name,String lon,String email,String lat) async{
    Logger().d("xxxxxxx"+id);
    users.put("token", token);
    users.put("name", name);
    users.put("lan", lon);
    users.put("email", email);
    users.put("userId", id);
    users.put("lat", lat);
  }

}


