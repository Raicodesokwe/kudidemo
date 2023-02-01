import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../data/habit_database.dart';
import '../../providers/color_provider.dart';
import '../../providers/habits_provider.dart';
import '../../widgets/back_arrow.dart';
import '../../widgets/color_overlay.dart';
import '../../widgets/habits/dailygoal_overlay.dart';
import '../../widgets/edit_text_field.dart';
import '../../widgets/neon_button.dart';
import '../../widgets/oval_container.dart';
import '../../widgets/oval_icon_container.dart';
import '../../widgets/repeat_overlay.dart';
import '../../widgets/routine_overlay.dart';
import '../../widgets/text_field.dart';

class EditHabit extends StatefulWidget {
  final String habitName;
  final void Function()? onSave;
  EditHabit({Key? key, required this.habitName, required this.onSave})
      : super(key: key);

  @override
  State<EditHabit> createState() => _EditHabitState();
}

class _EditHabitState extends State<EditHabit>
    with SingleTickerProviderStateMixin {
  final _myBox = Hive.box("Habit_Database");
  HabitDatabase db = HabitDatabase();
  final _editHabitsForm = GlobalKey<FormState>();
  late AnimationController controller;
  late Animation<double> fadeAnimation;
  late String habitsName;
  late String routine;
  late Color color;
  late bool repeat;
  late bool complete;
  late int count;
  late DateTime selectedTime;
  late List days;
  String name = '';

  checkFields() {
    final form = _editHabitsForm.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
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

  TextEditingController habitsNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final editNameProvider = Provider.of<HabitsProvider>(context);
    color = Provider.of<ColorProvider>(context).selectedColor!;
    count = Provider.of<HabitsProvider>(context).dailyGoal;
    selectedTime = Provider.of<HabitsProvider>(context).reminder;
    routine = Provider.of<HabitsProvider>(context).routine;
    repeat = Provider.of<HabitsProvider>(context).repeat;
    days = Provider.of<HabitsProvider>(context).days;
    complete = Provider.of<HabitsProvider>(context).complete;

    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    // Future saveForm() async {
    //   final isValid = _editHabitsForm.currentState!.validate();
    //   if (isValid && widget.name != '') {
    //     final habitProvider =
    //         Provider.of<HabitsProvider>(context, listen: false);

    //     db.updateDatabase();
    //     habitProvider.reset();
    //     Navigator.of(context).pop();
    //   }
    // }

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
    return Scaffold(
      body: Form(
          key: _editHabitsForm,
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
                // GestureDetector(
                //     onTap: () {
                //       // print('lengt dey ${days[0]}');
                //       print('lengt dey ${days.length}');
                //     },
                //     child: Container(
                //       height: 40,
                //       width: 40,
                //       color: Colors.blue,
                //     )),
                EditTextField(
                    onChanged: (value) {
                      setState(() {
                        name = value;
                        editNameProvider.editName = name;
                      });
                    },
                    initialValue: widget.habitName,
                    emptytext: 'task name is empty'),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        // onTap: () {
                        //   Platform.isIOS
                        //       ? showCupertinoDialog(
                        //           context: context,
                        //           builder: (_) => ColorOverlay(
                        //             color: color,
                        //           ),
                        //         )
                        //       : showDialog(
                        //           context: context,
                        //           builder: (_) => ColorOverlay(
                        //             color: color,
                        //           ),
                        //         );
                        // },
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
                          // onTap: () {
                          //   showDialog(
                          //     context: context,
                          //     builder: (_) => DailyGoalOverlay(),
                          //   );
                          // },
                          child: OvalContainer(text: 'Daily goal')),
                      GestureDetector(
                        // onTap: () {
                        //   showDialog(
                        //     context: context,
                        //     builder: (_) => RepeatOverlay(
                        //       selectedTime: selectedTime,
                        //     ),
                        //   );
                        // },
                        child: OvalIconContainer(
                          text: 'Repeat',
                          icon: Icons.repeat_on_sharp,
                          size: 12,
                        ),
                      ),
                      GestureDetector(
                          // onTap: () {
                          //   showDialog(
                          //     context: context,
                          //     builder: (_) => RoutineOverlay(
                          //       routine: routine,
                          //     ),
                          //   );
                          // },
                          child: OvalContainer(text: 'Routine'))
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.2,
                ),
                GestureDetector(onTap: widget.onSave, child: NeonButton()),
              ],
            ),
          )),
    );
  }
}
