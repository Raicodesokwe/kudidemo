import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/widgets/auth_textfield.dart';
import 'package:kudidemo/widgets/auth/pic_modal.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../navbar/navbar.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/next_button.dart';
import '../../widgets/nextneon_button.dart';

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
  final _kCam = "cam_preference";
  final _kName = "name_preference";
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
            AuthTextField(
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty || value.length < 4) {
                    return 'Please enter a valid username, at least 4 characters';
                  }
                  return null;
                },
                onChanged: (value) {
                  this.name = value;
                },
                keyboardType: TextInputType.text,
                hintText: 'username'),
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
                        var prefs = await SharedPreferences.getInstance();
                        prefs.setString(_kName, nameController.text.trim());
                        try {
                          if (imgFile != null) {
                            prefs.setString(_kCam, imgFile!.path);

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
