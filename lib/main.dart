import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sw_engineering_ibl/pages/LoginPage.dart';
import 'package:sw_engineering_ibl/pages/RegistrationPage.dart';
import 'package:sw_engineering_ibl/pages/SalonServices.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(NelApp());
}
DatabaseReference usersRef =FirebaseDatabase.instance.ref().child("users");

class NelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Ambulance App',
      theme: ThemeData(//default color for my app
        fontFamily: "Brand Bold",
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),
      //home: RegistrationPage(),
      debugShowCheckedModeBanner: false,//will remove that small line that this application is not in debug mode
      initialRoute: LoginPage.idScreen,
      routes: {
        RegistrationPage.idScreen: (context)=>RegistrationPage(),
        LoginPage.idScreen:(context)=>LoginPage(),
        SalonServices.idScreen:(context)=>SalonServices()

      },
    );
  }
}
