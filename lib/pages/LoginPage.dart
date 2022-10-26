
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Allwidgets/progressDialog.dart';


class LoginPage extends StatelessWidget {
  static const String idScreen = "login";
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ambulance Ride App"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      backgroundColor:  Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 1.0),
              Image(
                image: AssetImage("images/logo.png"),
                width: 250.0,
                height: 250.0,
                alignment: Alignment.center,
              ),
              SizedBox(height: 45.0,),
              Text("Login",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                        ),
                        hintStyle: TextStyle(fontSize: 10.0, color: Colors.grey,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(labelText: "Password", labelStyle: TextStyle( fontSize: 14.0,
                      ),
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 30.0,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(24.0)
                        ),
                        primary: Colors.red, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () {
                        if(!emailTextEditingController.text.contains("@"))
                        {
                          displayToastMessage("Email address not Valid", context);
                        } else if(passwordTextEditingController.text.isEmpty)
                        {
                          displayToastMessage("Please provide Password", context);
                        }else
                        {
                          loginAndAuthenticateuser(context);
                        }
                      },
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold",),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: (){
                  //Navigator.pushNamedAndRemoveUntil(context, RegistrationPage.idScreen, (route) => false);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                },
                child: Text(
                  "Do not have an account? Register Here",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateuser(BuildContext context) async {
    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return ProgressDialog(message: "Authenticating, Please wait..",);
        });

    final  firebaseUser = (await _firebaseAuth
        .signInWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text
    ).catchError((errMsg){
      Navigator.pop(context);//close dialogbox
      displayToastMessage("Error: "+ errMsg.toString(),context);
    })).user;
    if(firebaseUser != null){
      //check if user data exist in the database
      usersRef.child(firebaseUser.uid).once().then((snap){
        if(snap != null){
          Navigator.pushNamedAndRemoveUntil(context, RoleScreen.idScreen, (route) => false);
          displayToastMessage("You have login in successfully", context);
        }else{
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToastMessage("No records exist for this user", context);
        }
      });
    }
    else{//error occurred-display error message
      Navigator.pop(context);
      displayToastMessage("Error occurred", context);
    }
