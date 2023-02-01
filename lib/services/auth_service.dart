import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kudidemo/pages/auth/landing_screen.dart';
import 'package:kudidemo/pages/auth/name_pic.dart';
import 'package:kudidemo/pages/login/signin.dart';

import '../navbar/navbar.dart';
import '../pages/splash_screen.dart';

class AuthService {
  static handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting ||
              snapshot.hasError) {
            return SplashScreen();
          }
          return SplashScreen();
        });
  }

  static signOut(context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LandingScreen()));
    } on FirebaseAuthException catch (e) {
      var message = 'Something went wrong';
      if (e.message != null) {
        message = e.message!;
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  static resetPasswordLink(String email) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
