import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/navbar/navbar.dart';
import 'package:kudidemo/providers/google_signin.dart';
import 'package:kudidemo/services/auth_service.dart';

import 'package:kudidemo/widgets/next_button.dart';
import 'package:kudidemo/widgets/nextneon_button.dart';

import 'package:kudidemo/widgets/terms_privacypolicy.dart';

import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../providers/theme_provider.dart';

class SigninScreen extends StatefulWidget {
  SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController emailNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final _emailForm = GlobalKey<FormState>();

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
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.8,
                  decoration: decorator.copyWith(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TextFormField(
                    controller: emailNameController,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      this.email = value;
                    },
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                        hintText: 'email',
                        hintStyle: GoogleFonts.prompt(),
                        border: InputBorder.none),
                  )),

              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.8,
                  decoration: decorator.copyWith(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TextFormField(
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
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                        hintText: 'password',
                        hintStyle: GoogleFonts.prompt(),
                        border: InputBorder.none),
                  )),

              SizedBox(
                height: size.height * 0.05,
              ),
              if (!isKeyboard)
                GestureDetector(
                  onTap: () {
                    Provider.of<GoogleSignInProvider>(context, listen: false)
                        .googleLogin();
                  },
                  child: Container(
                    height: 50,
                    width: size.width * 0.8,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 30,
                            child: Image.asset('assets/images/GoogleLogo.png')),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Sign in with Google',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.black),
                  ),
                ),

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
