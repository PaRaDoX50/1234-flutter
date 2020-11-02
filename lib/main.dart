import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/utils/auth_firebase.dart';
import 'package:project/utils/database_methods.dart';
import 'package:splashscreen/splashscreen.dart';

import 'home.dart';
import 'signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meet Up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatelessWidget {
  final AuthMethods authMethods = AuthMethods();


  @override
  Widget build(BuildContext context) {

    Future<FirebaseUser> currentUser = authMethods.getCurrentUser();

    // User result = FirebaseAuth.instance.currentUser;
    //   return new SplashScreen(
    //       navigateAfterSeconds: result != null ? Home(uid: result.uid) : SignUp(),
    //       seconds: 5,
    //       title: new Text(
    //         'Welcome To Meet up!',
    //         style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
    //       ),
    //       image: Image.asset('assets/images/dart.png', fit: BoxFit.scaleDown),
    //       backgroundColor: Colors.white,
    //       styleTextUnderTheLoader: new TextStyle(),
    //       photoSize: 100.0,
    //       onClick: () => print("flutter"),
    //       loaderColor: Colors.red);
    // }

    return FutureBuilder <FirebaseUser>
      (future: currentUser, builder: (_, snapshot) {
        if(snapshot.hasData){

            return SplashScreen(
                navigateAfterSeconds:snapshot.data != null ? Home(uid: snapshot.data.uid) : SignUp(),
                seconds: 5,
                title: new Text(
                  'Welcome To Meet up!',
                  style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                image: Image.asset('assets/images/dart.png', fit: BoxFit.scaleDown),
                backgroundColor: Colors.white,
                styleTextUnderTheLoader: new TextStyle(),
                photoSize: 100.0,
                onClick: () => print("flutter"),
                loaderColor: Colors.red);

        }
        else{
          if(snapshot.connectionState == ConnectionState.done){
            return SplashScreen(
                navigateAfterSeconds:SignUp(),
                seconds: 5,
                title: new Text(
                  'Welcome To Meet up!',
                  style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                image: Image.asset('assets/images/dart.png', fit: BoxFit.scaleDown),
                backgroundColor: Colors.white,
                styleTextUnderTheLoader: new TextStyle(),
                photoSize: 100.0,
                onClick: () => print("flutter"),
                loaderColor: Colors.red);

          }
          return Center(child: CircularProgressIndicator(),);

        }



      });

  }



}
