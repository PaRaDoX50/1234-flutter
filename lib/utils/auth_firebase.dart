import 'package:firebase_auth/firebase_auth.dart';
class AuthMethods{

  FirebaseAuth auth = FirebaseAuth.instance;
  Future<FirebaseUser> getCurrentUser(){

    return auth.currentUser();
  }
}