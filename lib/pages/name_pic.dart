import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/widgets/pic_modal.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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

  File? imgFile;
  String? url;
  void _pickedImg(File img) {
    imgFile = img;
  }

  User? user = FirebaseAuth.instance.currentUser;

  var message = 'Something went wrong';

  bool isLoading = false;

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
    return Scaffold(
      body: Form(
        key: _nameForm,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            PicModal(imagePickFunktion: _pickedImg),
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
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 4) {
                      return 'Please enter a valid username, at least 4 characters';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.prompt(color: Colors.black),
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
                          if (imgFile != null) {
                            final ref = FirebaseStorage.instance
                                .ref()
                                .child('user_images')
                                .child(user!.uid + '.jpg');
                            await ref.putFile(imgFile!);
                            url = await ref.getDownloadURL();
                          }

                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(user!.uid)
                              .set({
                            'username': nameController.text.trim(),
                            'email': widget.email,
                            'image_url': url
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
                                    colors: [Colors.green, Colors.greenAccent],
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          )
                        : NextneonBtn(size: size, label: 'Next'))
                : NextBtn(size: size, label: 'Next'),
          ]),
        ),
      ),
    );
  }
}
