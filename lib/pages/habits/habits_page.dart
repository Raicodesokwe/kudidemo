import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:kudidemo/pages/habits/edit_habit.dart';

import 'package:kudidemo/providers/habits_provider.dart';
import 'package:kudidemo/utils/utils.dart';
import 'package:kudidemo/widgets/circle_button.dart';
import 'package:kudidemo/widgets/habits/dailygoal_overlay.dart';
import 'package:kudidemo/widgets/habits/habits_list.dart';
import 'package:kudidemo/widgets/icon_circle.dart';
import 'package:kudidemo/widgets/oval_container.dart';
import 'package:kudidemo/widgets/oval_icon_container.dart';
import 'package:kudidemo/widgets/repeat_overlay.dart';
import 'package:kudidemo/widgets/routine_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../data/habit_database.dart';
import '../../providers/color_provider.dart';
import '../../providers/theme_provider.dart';
import '../../services/notification_service.dart';
import '../../widgets/back_arrow.dart';
import '../../widgets/color_overlay.dart';
import '../../widgets/monthly_summary.dart';
import '../../widgets/neon_button.dart';
import '../../widgets/text_field.dart';
import '../homepage.dart';

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
  late bool complete;
  late int count;
  late DateTime selectedTime;
  late List days;
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
  bool isButtonPressed = false;
  List listItem = [];
  List incompleteList = [];
  final _myBox = Hive.box("Habit_Database");
  HabitDatabase db = HabitDatabase();
  @override
  void initState() {
    super.initState();
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }
    db.updateDatabase();
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

  bool inputWidget = false;
  @override
  Widget build(BuildContext context) {
    color = Provider.of<ColorProvider>(context).selectedColor!;
    count = Provider.of<HabitsProvider>(context).dailyGoal;
    selectedTime = Provider.of<HabitsProvider>(context).reminder;
    routine = Provider.of<HabitsProvider>(context).routine;
    repeat = Provider.of<HabitsProvider>(context).repeat;
    days = Provider.of<HabitsProvider>(context).days;
    complete = Provider.of<HabitsProvider>(context).complete;

    Future saveForm() async {
      final isValid = _habitsForm.currentState!.validate();
      if (isValid) {
        final habit = [
          Random().nextInt(10000),
          habitsNameController.text,
          color.value,
          selectedTime,
          repeat,
          days,
          complete,
          count,
          routine
        ];
        final habitProvider =
            Provider.of<HabitsProvider>(context, listen: false);
        setState(() {
          db.habits.add(habit);
          inputWidget = false;
        });
        db.updateDatabase();
        habitProvider.reset();
        habitsNameController.clear();
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

    return SafeArea(
      child: Scaffold(
        floatingActionButton: db.habits.isEmpty
            ? Container()
            : !inputWidget
                ? Theme(
                    data: Theme.of(context).copyWith(
                        floatingActionButtonTheme:
                            FloatingActionButtonThemeData(
                                extendedSizeConstraints:
                                    BoxConstraints.tightFor(
                      height: size.height * 0.07,
                      width: size.width * 0.45,
                    ))),
                    child: FloatingActionButton.extended(
                        backgroundColor: Colors.green,
                        elevation: 7,
                        icon: Icon(
                          Icons.add,
                          color: Theme.of(context).textTheme.bodyText2!.color,
                        ),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            inputWidget = true;
                          });
                        },
                        label: Text(
                          'Add new task',
                          style: Theme.of(context).textTheme.bodyText2,
                        )),
                  )
                : Container(),
        body: Form(
          key: _habitsForm,
          child: FadeTransition(
              opacity: fadeAnimation,
              child: Consumer<HabitsProvider>(
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
                    //       print('lengt dey ${selectedTime}');
                    //     },
                    //     child: Container(
                    //       height: 40,
                    //       width: 40,
                    //       color: Colors.blue,
                    //     )),
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
                            : CircleButton()),
                  ],
                ),
                builder: ((context, value, child) {
                  if (db.habits.isEmpty || inputWidget) {
                    return child!;
                  }
                  return HabitsList();
                }),
              )),
        ),
      ),
    );
  }
}
