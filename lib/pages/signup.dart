import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/navbar/navbar.dart';
import 'package:kudidemo/services/auth_service.dart';
import 'package:kudidemo/widgets/auth_textfield.dart';
import 'package:kudidemo/widgets/next_button.dart';
import 'package:kudidemo/widgets/nextneon_button.dart';
import 'package:kudidemo/widgets/privacy_dialog.dart';
import 'package:kudidemo/widgets/terms_dialog.dart';
import 'package:kudidemo/widgets/terms_privacypolicy.dart';
import 'package:kudidemo/widgets/text_field.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  TextEditingController emailNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _emailForm = GlobalKey<FormState>();
  checkFields() {
    final form = _emailForm.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeProvider>(context).darkTheme;
    final BoxDecoration decorator = BoxDecoration(
      boxShadow: themeData
          ? [
              BoxShadow(
                  color: Colors.grey.shade500,
                  offset: Offset(4, 4),
                  blurRadius: 15,
                  spreadRadius: 1),
              BoxShadow(
                spreadRadius: 1,
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 15,
              )
            ]
          : [
              BoxShadow(
                  color: Colors.black,
                  offset: Offset(5, 5),
                  blurRadius: 15,
                  spreadRadius: 5),
              BoxShadow(
                spreadRadius: 1,
                color: Colors.grey.shade800,
                offset: Offset(-4, -4),
                blurRadius: 15,
              )
            ],
    );
    Size size = MediaQuery.of(context).size;
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      body: Form(
        key: _emailForm,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthTextField(
                  controller: emailNameController,
                  validate: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  hintText: 'email',
                  hidepassword: false,
                  textInputType: TextInputType.emailAddress),

              SizedBox(
                height: size.height * 0.03,
              ),
              AuthTextField(
                  controller: passwordController,
                  validate: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                  hintText: 'password',
                  hidepassword: true,
                  textInputType: TextInputType.none),
              SizedBox(
                height: size.height * 0.03,
              ),
              AuthTextField(
                  controller: confirmPasswordController,
                  validate: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Please enter a valid password that matches';
                    } else if (value != passwordController.text) {
                      return 'Password must match the one above';
                    }

                    return null;
                  },
                  hintText: 'confirm password',
                  hidepassword: true,
                  textInputType: TextInputType.none),

              SizedBox(
                height: size.height * 0.05,
              ),
              if (!isKeyboard)
                Container(
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
                        style: TextStyle(
                            color: themeData ? Colors.white : Colors.black),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: themeData ? Colors.black : Colors.white),
                ),

              SizedBox(
                height: size.height * 0.1,
              ),
              // if (!isKeyboard)
              emailNameController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        if (checkFields())
                          // AuthService.signIn(emailNameController.text,
                          //     passwordController.text, context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BottomNavBar()));
                      },
                      child: NextneonBtn(size: size, label: 'Sign in'),
                    )
                  : NextBtn(size: size, themeData: themeData, label: 'Sign in'),
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
