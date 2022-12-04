import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/models/habits_model.dart';
import 'package:kudidemo/providers/habits_provider.dart';
import 'package:kudidemo/utils/utils.dart';
import 'package:kudidemo/widgets/circle_button.dart';
import 'package:kudidemo/widgets/dailygoal_overlay.dart';
import 'package:kudidemo/widgets/oval_container.dart';
import 'package:kudidemo/widgets/oval_icon_container.dart';
import 'package:kudidemo/widgets/repeat_overlay.dart';
import 'package:kudidemo/widgets/routine_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../providers/color_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/back_arrow.dart';
import '../widgets/color_overlay.dart';
import '../widgets/neon_button.dart';
import '../widgets/text_field.dart';
import 'homepage.dart';

class HabitsPage extends StatefulWidget {
  HabitsPage({Key? key}) : super(key: key);

  @override
  State<HabitsPage> createState() => _HabitsPageState();
}

class _HabitsPageState extends State<HabitsPage>
    with SingleTickerProviderStateMixin {
  late String habitsName;
  late String routine;
  late Color color;
  late bool repeat;
  late int count;
  late DateTime selectedTime;
  TextEditingController habitsNameController = TextEditingController();

  final _habitsForm = GlobalKey<FormState>();

  checkFields() {
    final form = _habitsForm.currentState;
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
    color = Provider.of<ColorProvider>(context).selectedColor!;
    count = Provider.of<HabitsProvider>(context).dailyGoal;
    selectedTime = Provider.of<HabitsProvider>(context).reminder!;
    routine = Provider.of<HabitsProvider>(context).routine!;
    repeat = Provider.of<HabitsProvider>(context).repeat;

    Future saveForm() async {
      final isValid = _habitsForm.currentState!.validate();
      if (isValid) {
        final habit = HabitsModel(
          id: Random().nextInt(10000),
          name: habitsNameController.text,
          color: color.value,
          reminder: selectedTime,
          repeat: repeat,
        );
        final habitProvider =
            Provider.of<HabitsProvider>(context, listen: false);
        habitProvider.addHabits(habit).then((value) => habitProvider.reset());

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (c) => HomePage()), (route) => false);
      }
    }

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
        key: _habitsForm,
        child: FadeTransition(
          opacity: fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isKeyboard)
                BackArrow(
                  decorator: decorator,
                ),
              if (!isKeyboard)
                Center(
                  child: SizedBox(
                      width: size.width * 0.4,
                      child: Lottie.asset('assets/images/habit.json')),
                ),
              SizedBox(
                height: size.height * 0.03,
              ),
              if (!isKeyboard)
                Text('Habits',
                    style: TextStyle(
                        color: Theme.of(context).backgroundColor,
                        fontSize: 50,
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
              GestureDetector(
                  onTap: () {
                    print('dis ist $routine');
                  },
                  child: Container(height: 50, width: 50, color: Colors.blue)),
              CustomTextField(
                  controller: habitsNameController,
                  emptytext: 'habit name is required',
                  hintText: 'Habit name'),
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Platform.isIOS
                            ? showCupertinoDialog(
                                context: context,
                                builder: (_) => ColorOverlay(
                                  color: color,
                                ),
                              )
                            : showDialog(
                                context: context,
                                builder: (_) => ColorOverlay(
                                  color: color,
                                ),
                              );
                      },
                      child: Container(
                          padding: const EdgeInsets.all(7),
                          child: Center(
                              child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: color, shape: BoxShape.circle),
                          )),
                          decoration: decorator.copyWith(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => DailyGoalOverlay(),
                          );
                        },
                        child: OvalContainer(text: 'Daily goal')),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => RepeatOverlay(
                            selectedTime: selectedTime,
                          ),
                        );
                      },
                      child: OvalIconContainer(
                        text: 'Repeat',
                        icon: Icons.repeat_on_sharp,
                        size: 12,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => RoutineOverlay(
                              routine: routine,
                            ),
                          );
                        },
                        child: OvalContainer(text: 'Routine'))
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.2,
              ),
              GestureDetector(
                  onTap: () => saveForm(),
                  child: habitsNameController.text.isNotEmpty
                      ? NeonButton()
                      : CircleButton())
            ],
          ),
        ),
      ),
    );
  }
}
