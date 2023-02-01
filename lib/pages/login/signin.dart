import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kudidemo/navbar/navbar.dart';
import 'package:kudidemo/pages/auth/name_pic.dart';
import 'package:kudidemo/providers/google_signin.dart';
import 'package:kudidemo/services/auth_service.dart';
import 'package:kudidemo/widgets/auth_textfield.dart';

import 'package:kudidemo/widgets/next_button.dart';
import 'package:kudidemo/widgets/nextneon_button.dart';

import 'package:kudidemo/widgets/auth/terms_privacypolicy.dart';

import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../providers/theme_provider.dart';
import '../../widgets/google_sign_in.dart';

class SigninScreen extends StatefulWidget {
  SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController emailNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
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
    Size size = MediaQuery.of(context).size;
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    bool isLoading = false;
    void_trySubmit() async {}
    return Scaffold(
      body: Form(
        key: _emailForm,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthTextField(
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
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'email'),

              SizedBox(
                height: size.height * 0.03,
              ),
              AuthTextField(
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
                  keyboardType: TextInputType.visiblePassword,
                  hintText: 'password'),

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
                            .signInWithCredential(credential);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavBar()));
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
                    child: GoogleWidget(sign: 'in')),

              SizedBox(
                height: size.height * 0.1,
              ),
              // if (!isKeyboard)
              emailNameController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty
                  ? GestureDetector(
                      onTap: () async {
                        if (checkFields()) {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email.trim(),
                                    password: password.trim());
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavBar()));
                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                            var message = 'Something went wrong';
                            if (e.message != null) {
                              message = e.message!;
                            }
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(message)));
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
                          : NextneonBtn(size: size, label: 'Sign in'),
                    )
                  : NextBtn(size: size, label: 'Sign in'),
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
