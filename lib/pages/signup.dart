import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kudidemo/navbar/navbar.dart';
import 'package:kudidemo/widgets/auth_textfield.dart';
import 'package:kudidemo/widgets/google_sign_in.dart';

import 'package:kudidemo/widgets/next_button.dart';
import 'package:kudidemo/widgets/nextneon_button.dart';

import 'package:kudidemo/widgets/terms_privacypolicy.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../providers/theme_provider.dart';
import '../services/auth_service.dart';
import 'name_pic.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  final _emailForm = GlobalKey<FormState>();
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  User? currentUser = FirebaseAuth.instance.currentUser;
  checkFields() {
    final form = _emailForm.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  late String email;

  late String password;
  late String confirmPassword;
  bool isLoading = false;
  var message = 'Something went wrong';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    final decorator = BoxDecoration(boxShadow: [
      BoxShadow(
          color: Theme.of(context).cardColor,
          offset: Offset(5, 5),
          blurRadius: 15,
          spreadRadius: 5),
      BoxShadow(
        spreadRadius: 1,
        color: Theme.of(context).canvasColor,
        offset: Offset(-5, -5),
        blurRadius: 15,
      )
    ]);
    return Scaffold(
      body: Form(
        key: _emailForm,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailNameController,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    this.email = value;
                  },
                  hintText: 'email'),
              SizedBox(
                height: size.height * 0.03,
              ),
              AuthTextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    this.password = value;
                  },
                  hintText: 'password'),
              SizedBox(
                height: size.height * 0.03,
              ),
              AuthTextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Please enter a valid password that matches';
                    } else if (value != passwordController.text) {
                      return 'Password must match the one above';
                    }

                    return null;
                  },
                  onChanged: (value) {
                    confirmPassword = value;
                  },
                  hintText: 'confirm password'),
              SizedBox(
                height: size.height * 0.05,
              ),
              if (!isKeyboard)
                GestureDetector(
                    onTap: () async {
                      // Provider.of<GoogleSignInProvider>(context, listen: false)
                      //     .googleLogin(context);

                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => BottomNavBar()));
                      try {
                        String? googleEmail;
                        final googleUser = await googleSignIn.signIn();
                        if (googleUser == null) return;
                        _user = googleUser;
                        final googleAuth = await googleUser.authentication;
                        final credential = GoogleAuthProvider.credential(
                            accessToken: googleAuth.accessToken,
                            idToken: googleAuth.idToken);
                        await FirebaseAuth.instance
                            .signInWithCredential(credential)
                            .then((value) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NamePicScreen(
                                          email: value.user!.email!,
                                        ))));

                        //     .then((value) async {
                        //   googleEmail = value.user!.email;
                        //   await FirebaseFirestore.instance
                        //       .collection('users')
                        //       .doc(value.user!.uid)
                        //       .get()
                        //       .then((value) {
                        //     if (!value.exists) {
                        //       Navigator.pushReplacement(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) => NamePicScreen(
                        //                     email: googleEmail!,
                        //                   )));
                        //     } else {
                        //       Navigator.pushReplacement(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) => BottomNavBar()));
                        //     }
                        //   });
                        // });
                      } on FirebaseAuthException catch (e) {
                        var message = 'Something went wrong';
                        if (e.message != null) {
                          message = e.message!;
                        }
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(message)));
                      }
                    },
                    child: GoogleWidget(sign: 'up')),
              SizedBox(
                height: size.height * 0.05,
              ),
              if (!isKeyboard)
                emailNameController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () async {
                          if (checkFields()) {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: email.trim(),
                                      password: password.trim());
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NamePicScreen(email: email)));
                            } on FirebaseAuthException catch (e) {
                              setState(() {
                                isLoading = false;
                              });

                              if (e.message != null) {
                                message = e.message!;
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(e.message.toString())));
                            }
                          }
                        },
                        child: isLoading
                            ? Shimmer.fromColors(
                                baseColor: Colors.green,
                                highlightColor: Colors.green.withOpacity(0.5),
                                child: Container(
                                  height: 50,
                                  width: size.width * 0.4,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.green.withAlpha(225),
                                          blurRadius: 45,
                                          spreadRadius: 15,
                                          offset: Offset(0, 0))
                                    ],
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.green,
                                          Colors.greenAccent
                                        ],
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              )
                            : NextneonBtn(size: size, label: 'Sign up'),
                      )
                    : NextBtn(size: size, label: 'Sign up'),
              SizedBox(
                height: size.height * 0.05,
              ),
              TermsPrivacyPolicy()
            ],
          ),
        ),
      ),
    );
  }
}
