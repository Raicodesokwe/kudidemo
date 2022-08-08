import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/widgets/circle_button.dart';
import 'package:kudidemo/widgets/oval_icon_container.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../widgets/back_arrow.dart';
import '../widgets/text_field.dart';

class GroupTask extends StatefulWidget {
  GroupTask({Key? key}) : super(key: key);

  @override
  State<GroupTask> createState() => _GroupTaskState();
}

class _GroupTaskState extends State<GroupTask>
    with SingleTickerProviderStateMixin {
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

  late AnimationController controller;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 950));
    fadeAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
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
          child: FadeTransition(
            opacity: fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isKeyboard)
                  BackArrow(decorator: decorator, themeData: themeData),
                if (!isKeyboard)
                  Center(
                    child: SizedBox(
                        width: size.width * 0.3,
                        child: Lottie.asset('assets/images/group.json')),
                  ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                if (!isKeyboard)
                  Text('Group Task',
                      style: TextStyle(
                          color:
                              themeData ? Colors.grey[300] : Colors.grey[900],
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
                  height: size.height * 0.015,
                ),
                CustomTextField(
                    controller: groupTaskNameController,
                    emptytext: 'task name is required',
                    hintText: 'Describe task'),
                SizedBox(
                  height: size.height * 0.015,
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
                              color:
                                  themeData ? Colors.black45 : Colors.white54,
                              fontSize: 10,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    decoration: decorator.copyWith(
                        color: themeData ? Colors.grey[300] : Colors.grey[900],
                        borderRadius: BorderRadius.circular(30))),
                SizedBox(
                  height: 10,
                ),
                if (!isKeyboard)
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
                                  child: Image.asset(
                                'assets/images/girl.png',
                                scale: 2,
                              )),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                border:
                                    Border.all(color: Colors.black54, width: 4),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Positioned(
                                left: 40,
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  child: Center(
                                      child: Image.asset(
                                    'assets/images/man.png',
                                    scale: 3,
                                  )),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    border: Border.all(
                                        color: Colors.black54, width: 4),
                                    shape: BoxShape.circle,
                                  ),
                                )),
                            Positioned(
                                left: 80,
                                child: Container(
                                  child: Center(
                                      child: Image.asset(
                                    'assets/images/girl.png',
                                    scale: 2,
                                  )),
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.purple,
                                    border: Border.all(
                                        color: Colors.black, width: 4),
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
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                if (!isKeyboard)
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
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300),
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
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
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
                      OvalIconContainer(
                          text: 'In progress',
                          icon: FontAwesomeIcons.barsProgress,
                          size: 15),
                      OvalIconContainer(
                          text: 'To do',
                          icon: FontAwesomeIcons.noteSticky,
                          size: 15),
                      OvalIconContainer(
                          text: 'In review',
                          icon: FontAwesomeIcons.thumbsUp,
                          size: 15),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                CircleButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
