
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SalonServices extends StatefulWidget {
  //const SalonServices({Key? key}) : super(key: key);
  static const String idScreen = "salonservices";

  @override
  State<SalonServices> createState() => _SalonServicesState();
}

class _SalonServicesState extends State<SalonServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text("Salon App"),
    centerTitle: true,
    backgroundColor: Colors.purple,
    ),backgroundColor:  Colors.white,
    body: SingleChildScrollView(
    child: Padding(
    padding: EdgeInsets.all(8.0),
    child: Column(
    children: [
    SizedBox(height: 1.0),
    Image(
    image: AssetImage("images/salonimg.png"),
    width: 250.0,
    height: 250.0,
    alignment: Alignment.center,
    )]
    )
    )
    )
    );
  }
}
