// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:progress_button/progress_button.dart';
import 'package:user_location_get_app/Presentation/Widgets/Button/ProgressAnimatedButton.dart';
import 'package:user_location_get_app/Presentation/Widgets/TextField/NormalTextField.dart';
import 'package:user_location_get_app/User/user_cubit.dart';

import '../UpdateLocation.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;
  double _totalDistance = 0;
  String address;
  String id;
  final _globalkey = GlobalKey<FormState>();
  bool circule=false;
  bool validate;
  ButtonState progressButtonState = ButtonState.normal;
  TextEditingController lan=new TextEditingController();
  TextEditingController lot=new TextEditingController();
  @override
  void initState() {
    super.initState();
    getData();
    getCureentLocation();
  }
  void getCureentLocation()async{
    var possition=await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lastPosition=await Geolocator().getLastKnownPosition();
    print(lastPosition);
    print(possition.latitude);
    print(possition.longitude);

    //location name
    final coordinates = new Coordinates(
        possition.latitude, possition.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);


    print("yyyy: "+addresses.first.subAdminArea);
    print("yyyy: "+addresses.first.addressLine);
    print("yyyy: "+addresses.first.featureName);
    setState(() {
      address=addresses.first.subAdminArea;
      lan.text= possition.latitude.toString();
      lot.text= possition.longitude.toString();
    });
    // print("yyyy: "+addresses.first.subThoroughfare);

    //location name

    if ((await Geolocator().isLocationServiceEnabled())) {
      var distanceInMeters = await Geolocator().distanceBetween(23.794920200241254, 90.41413134519485,possition.latitude,possition.longitude);// lat2 and long2 are global variables with current user's location
      print("xxx "+distanceInMeters.toString());
      setState(() {
        _totalDistance+=distanceInMeters;
      });

    }else{
      print("GPS is off.");
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: const Text('Make sure your GPS is on in Settings !'),
              actions: <Widget>[
                FlatButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    })
              ],
            );
          });
    }

  }
  void getData() async{
    var users= await Hive.openBox('users');
    print("hive "+users.get('token'));
    if (users.get('token') != null) {
      setState(() {
        id=users.get('userId');

      });
    } else {

    }
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(isDrawerOpen ? 0.85 : 1.00)
        ..rotateZ(isDrawerOpen ? -50 : 0),
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.circular(0),
      ),
      child: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if(state is Updated){
            setState(() {
              circule=false;
            });
          }
          // TODO: implement listener}
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.deepOrange,
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    isDrawerOpen
                        ? GestureDetector(
                      child: Icon(Icons.arrow_back_ios,color: Colors.white,),
                      onTap: () {
                        setState(() {
                          xOffset = 0;
                          yOffset = 0;
                          isDrawerOpen = false;
                        });
                      },
                    )
                        : GestureDetector(
                      child: Icon(Icons.menu,color: Colors.white,),
                      onTap: () {
                        setState(() {
                          xOffset = 330;
                          yOffset = 80;
                          isDrawerOpen = true;
                        });
                      },
                    ),
                    const Text(
                      'Home Page',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          decoration: TextDecoration.none),
                    ),
                    Container(),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.9,
                child: Column(
                  children:[
                    lan.text==null?Container():Container(child: Text(address==null?"":address),),
                    lan.text==null?Container():NormalInputField(controller:lan ,hintText: "Enter Your Email",icon: Icons.alternate_email,),
                    lan.text==null?Container():NormalInputField(controller:lot ,hintText: "Enter Your Email",icon: Icons.alternate_email,),

                    circule?Center(child: CircularProgressIndicator(),):  InkWell(
                      onTap: (){
                        setState(() {
                          circule=true;
                        });
                        BlocProvider.of<UserCubit>(context).updateLanLot(lan.text,lot.text,id);
                      },
                      child: Container(
                        color: Colors.blueAccent,
                        width: 300,
                        height: 50,
                        child: Center(child: Text("update"),),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

