import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/widgets/next_button.dart';
import 'package:kudidemo/widgets/nextneon_button.dart';
import 'package:kudidemo/widgets/terms_dialog.dart';
import 'package:kudidemo/widgets/text_field.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({Key? key}) : super(key: key);
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
    Future termsDialog(BuildContext context) {
      return Platform.isIOS
          ? showCupertinoDialog(context: context, builder: (_) => TermsDialog())
          : showDialog(context: context, builder: (_) => TermsDialog());
    }

    return Scaffold(
      body: Form(
        key: _emailForm,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                  controller: emailNameController,
                  emptytext: 'email is required',
                  hintText: 'email'),
              SizedBox(
                height: size.height * 0.03,
              ),
              CustomTextField(
                  controller: passwordController,
                  emptytext: 'password is required',
                  hintText: 'password'),
              SizedBox(
                height: size.height * 0.03,
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
                height: size.height * 0.03,
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
                          child: Icon(
                            Icons.phone,
                            color: themeData ? Colors.white : Colors.black,
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Sign in with Phone',
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
                height: size.height * 0.2,
              ),
              if (!isKeyboard)
                GestureDetector(
                  onTap: () {},
                  child: emailNameController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty
                      ? Container(
                          height: 50,
                          width: size.width * 0.4,
                          child: Center(
                            child: Text(
                              'Sign in',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.green.withAlpha(225),
                                    blurRadius: 45,
                                    spreadRadius: 15,
                                    offset: Offset(0, 0))
                              ],
                              gradient: LinearGradient(
                                  colors: [Colors.green, Colors.greenAccent],
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft),
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(width: 4, color: Colors.black54)),
                        )
                      : Container(
                          height: 50,
                          width: size.width * 0.4,
                          child: Center(
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                  color:
                                      themeData ? Colors.black : Colors.white),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 4,
                                  color: themeData
                                      ? Colors.black54
                                      : Colors.white54)),
                        ),
                ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                      width: double.infinity,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'By continuing, you are agreeing to our',
                              style: GoogleFonts.prompt(color: Colors.black),
                            ),
                            TextSpan(
                                text: ' Terms of Service ',
                                style: GoogleFonts.prompt(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFFF773D)),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    termsDialog(context);
                                  }),
                            TextSpan(
                              text: 'and ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                                text: 'Privacy Policy',
                                style: GoogleFonts.prompt(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFFF773D)),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {}),
                            TextSpan(
                              text: '.',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
