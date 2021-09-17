// ignore_for_file: file_names


import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:user_location_get_app/Presentation/Widgets/TextField/NormalTextField.dart';


class LanLotUpdate extends StatefulWidget {
  @override
  _LanLotUpdateState createState() => _LanLotUpdateState();
}

class _LanLotUpdateState extends State<LanLotUpdate> {
  double _totalDistance = 0;
  String address;
  TextEditingController lan=new TextEditingController();
  TextEditingController lot=new TextEditingController();
  @override
  void initState() {
    super.initState();
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
  @override
  Widget build(BuildContext context) {
    return lan.text==null?Container():Column(
      children: [

      ],
    );
  }
}
