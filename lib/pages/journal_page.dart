import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class JournalPage extends StatelessWidget {
  JournalPage({Key? key}) : super(key: key);
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String date = DateFormat('yMMMMd').format(now);
    String time = DateFormat('jm').format(now);
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                          height: 70,
                          width: 70,
                          decoration: decorator.copyWith(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/images/journalwrite.png')),
                          )),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: themeData
                                    ? Colors.grey[300]
                                    : Colors.grey[900],
                                borderRadius: BorderRadius.circular(7)),
                            child: Center(
                              child: Icon(
                                Icons.camera_alt_sharp,
                                color:
                                    themeData ? Colors.black87 : Colors.white70,
                                size: 12,
                              ),
                            ),
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        date,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        time,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Container(
                      padding: const EdgeInsets.all(12),
                      child: Center(
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.floppyDisk,
                              color:
                                  themeData ? Colors.black87 : Colors.white70,
                              size: 17,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Save',
                              style: TextStyle(
                                  color: themeData
                                      ? Colors.black87
                                      : Colors.white70,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      decoration: decorator.copyWith(
                          color:
                              themeData ? Colors.grey[300] : Colors.grey[900],
                          borderRadius: BorderRadius.circular(30))),
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: decorator.copyWith(
                        color: themeData ? Colors.grey[300] : Colors.grey[900],
                        borderRadius: BorderRadius.circular(7)),
                    child: Center(
                      child: Icon(
                        Icons.camera,
                        color: themeData ? Colors.black54 : Colors.white60,
                        size: 25,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: decorator.copyWith(
                        color: themeData ? Colors.grey[300] : Colors.grey[900],
                        shape: BoxShape.circle),
                    child: Center(
                      child: Icon(
                        Icons.emoji_emotions,
                        color: themeData ? Colors.black54 : Colors.white60,
                        size: 25,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: decorator.copyWith(
                        color: themeData ? Colors.grey[300] : Colors.grey[900],
                        borderRadius: BorderRadius.circular(7)),
                    child: Center(
                        child: Image.asset(
                      'assets/images/fonts.png',
                      scale: 4,
                      color: themeData ? Colors.black54 : Colors.white54,
                    )),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: decorator.copyWith(
                        color: themeData ? Colors.grey[300] : Colors.grey[900],
                        borderRadius: BorderRadius.circular(7)),
                    child: Center(
                        child: Icon(
                      Icons.mic_sharp,
                      color: themeData ? Colors.black54 : Colors.white60,
                      size: 25,
                    )),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: decorator.copyWith(
                        color: themeData ? Colors.grey[300] : Colors.grey[900],
                        borderRadius: BorderRadius.circular(7)),
                    child: Center(
                        child: Icon(
                      FontAwesomeIcons.tag,
                      color: themeData ? Colors.black54 : Colors.white60,
                      size: 25,
                    )),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: double.infinity,
                  decoration: decorator.copyWith(
                      color: themeData ? Colors.grey[300] : Colors.grey[900],
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Title is required' : null,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                        hintText: 'Title',
                        hintStyle: GoogleFonts.prompt(),
                        border: InputBorder.none),
                  )),
              SizedBox(
                height: size.height * 0.025,
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  height: size.height * 0.5,
                  width: double.infinity,
                  decoration: decorator.copyWith(
                      color: themeData ? Colors.grey[300] : Colors.grey[900],
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Title is required' : null,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                        hintText: 'Dear diary...',
                        hintStyle: GoogleFonts.prompt(),
                        border: InputBorder.none),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
