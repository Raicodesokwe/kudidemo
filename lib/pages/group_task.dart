import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class GroupTask extends StatelessWidget {
  GroupTask({Key? key}) : super(key: key);

  late String groupTaskName;

  TextEditingController groupTaskNameController = TextEditingController();
  final _groupTaskForm = GlobalKey<FormState>();
  checkFields() {
    final form = _groupTaskForm.currentState;
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
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _groupTaskForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isKeyboard)
                Center(
                  child: SizedBox(
                      width: size.width * 0.4,
                      child: Lottie.asset('assets/images/group.json')),
                ),
              SizedBox(
                height: size.height * 0.03,
              ),
              if (!isKeyboard)
                Text('Group Task',
                    style: TextStyle(
                        color: themeData ? Colors.grey[300] : Colors.grey[900],
                        fontSize: 45,
                        shadows: const [
                          Shadow(
                              color: Color.fromARGB(255, 92, 202, 96),
                              blurRadius: 8),
                          Shadow(
                              color: Color.fromARGB(255, 92, 202, 96),
                              blurRadius: 10),
                          Shadow(
                              color: Color.fromARGB(255, 92, 202, 96),
                              blurRadius: 12),
                        ])),
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
                    validator: (value) =>
                        value!.isEmpty ? 'task name is required' : null,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                        hintText: 'Describe task',
                        hintStyle: GoogleFonts.prompt(),
                        border: InputBorder.none),
                  )),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FontAwesomeIcons.photoFilm,
                        color: themeData ? Colors.black54 : Colors.white54,
                        size: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Attach photo',
                        style: TextStyle(
                            color: themeData ? Colors.black45 : Colors.white54,
                            fontSize: 10,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  decoration: decorator.copyWith(
                      color: themeData ? Colors.grey[300] : Colors.grey[900],
                      borderRadius: BorderRadius.circular(30))),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          child: Center(
                            child: Icon(
                              Icons.person_outline,
                              color: Colors.white,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(color: Colors.black54, width: 4),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Positioned(
                            left: 40,
                            child: Container(
                              height: 60,
                              width: 60,
                              child: Center(
                                child: Icon(
                                  Icons.person_outline,
                                  color: Colors.white,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                border:
                                    Border.all(color: Colors.black54, width: 4),
                                shape: BoxShape.circle,
                              ),
                            )),
                        Positioned(
                            left: 80,
                            child: Container(
                              child: Center(
                                child: Icon(
                                  Icons.person_outline,
                                  color: Colors.white,
                                ),
                              ),
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                border:
                                    Border.all(color: Colors.black, width: 4),
                                shape: BoxShape.circle,
                              ),
                            )),
                        Positioned(
                            left: 120,
                            child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  border: Border.all(
                                      color: Colors.black54, width: 4),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.black54,
                                  ),
                                ))),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Add friends to task',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              FontAwesomeIcons.message,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Chat',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        decoration: decorator.copyWith(
                            color: themeData
                                ? Colors.greenAccent
                                : Colors.redAccent,
                            borderRadius: BorderRadius.circular(30))),
                    Text(
                      'Chat with added friends',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.barsProgress,
                                color:
                                    themeData ? Colors.black54 : Colors.white54,
                                size: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'In progress',
                                style: TextStyle(
                                    color: themeData
                                        ? Colors.black45
                                        : Colors.white54,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                        decoration: decorator.copyWith(
                            color:
                                themeData ? Colors.grey[300] : Colors.grey[900],
                            borderRadius: BorderRadius.circular(30))),
                    Container(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.noteSticky,
                                color:
                                    themeData ? Colors.black54 : Colors.white54,
                                size: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'To do',
                                style: TextStyle(
                                    color: themeData
                                        ? Colors.black45
                                        : Colors.white54,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                        decoration: decorator.copyWith(
                            color:
                                themeData ? Colors.grey[300] : Colors.grey[900],
                            borderRadius: BorderRadius.circular(30))),
                    Container(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.thumbsUp,
                                color:
                                    themeData ? Colors.black54 : Colors.white54,
                                size: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'In review',
                                style: TextStyle(
                                    color: themeData
                                        ? Colors.black45
                                        : Colors.white54,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300),
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
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Container(
                child: Center(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Center(
                      child: Icon(
                        Icons.send,
                        color: themeData ? Colors.black54 : Colors.white54,
                        size: 50,
                      ),
                    ),
                  ),
                ),
                height: 100,
                width: 100,
                decoration: decorator.copyWith(
                    color: themeData ? Colors.grey[300] : Colors.grey[900],
                    border: Border.all(
                        width: 10,
                        color: themeData ? Colors.black54 : Colors.white54),
                    shape: BoxShape.circle),
              )
            ],
          ),
        ),
      ),
    );
  }
}
