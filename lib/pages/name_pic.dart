import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../navbar/navbar.dart';
import '../providers/theme_provider.dart';
import '../widgets/next_button.dart';
import '../widgets/nextneon_button.dart';

class NamePicScreen extends StatefulWidget {
  final String email;
  NamePicScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<NamePicScreen> createState() => _NamePicScreenState();
}

class _NamePicScreenState extends State<NamePicScreen> {
  TextEditingController nameController = TextEditingController();

  final _nameForm = GlobalKey<FormState>();

  checkFields() {
    final form = _nameForm.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  late String name;

  late File imgFile;

  void _pickedImg(File img) {
    imgFile = img;
  }

  User? user = FirebaseAuth.instance.currentUser;

  var message = 'Something went wrong';

  bool isLoading = false;

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
        key: _nameForm,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                decoration: decorator.copyWith(
                    color: themeData ? Colors.grey[300] : Colors.grey[900],
                    borderRadius: BorderRadius.circular(10.0)),
                child: TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 4) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    this.name = value;
                  },
                  cursorColor: Colors.black45,
                  decoration: InputDecoration(
                      hintText: 'username',
                      hintStyle: GoogleFonts.prompt(),
                      border: InputBorder.none),
                )),
            SizedBox(
              height: size.height * 0.05,
            ),
            nameController.text.isNotEmpty
                ? GestureDetector(
                    onTap: () async {
                      if (checkFields()) {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(user!.uid)
                              .set({
                            'username': nameController.text.trim(),
                            'email': widget.email
                          });
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomNavBar()));
                        } on FirebaseAuthException catch (e) {
                          setState(() {
                            isLoading = false;
                          });
                          if (e.message != null) {
                            message = e.message!;
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.message.toString())));
                        }
                      }
                    },
                    child: NextneonBtn(size: size, label: 'Next'))
                : NextBtn(size: size, themeData: themeData, label: 'Next'),
          ]),
        ),
      ),
    );
  }
}
