import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/models/habits_model.dart';
import 'package:kudidemo/navbar/navbar.dart';
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
  bool isButtonPressed = false;
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

  int habitCompleted = 0;
  Map<DateTime, int>? datasets;
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
            routine: routine);
        final habitProvider =
            Provider.of<HabitsProvider>(context, listen: false);
        habitProvider.addHabits(habit).then((value) => habitProvider.reset());
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
        body: Form(
          key: _habitsForm,
          child: FadeTransition(
            opacity: fadeAnimation,
            child:
                Consumer<HabitsProvider>(builder: (context, notifier, child) {
              final listLength = notifier.habits.length;
              final habitItem = notifier.habits;

              return listLength > 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          BackArrow(
                            decorator: decorator,
                          ),
                          Container(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: decorator.copyWith(
                                            shape: BoxShape.circle,
                                            color: Theme.of(context)
                                                .backgroundColor),
                                        child: Center(
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            child: Icon(
                                                FontAwesomeIcons.handPointUp),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red
                                                    .withOpacity(0.1)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Long press button to\nmark task as complete',
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                  FontAwesomeIcons.exclamation),
                                              Text(
                                                'It takes an average of 66 days for a\nnew behaviour to become automatic',
                                                style: GoogleFonts.prompt(
                                                    fontSize: 11),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                  FontAwesomeIcons.exclamation),
                                              Text(
                                                'It takes an average of 10000 hours to \nbecome an expert at something',
                                                style: GoogleFonts.prompt(
                                                    fontSize: 11),
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: decorator.copyWith(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context).backgroundColor)),
                          SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              DateTime startDate = habitItem[index].reminder!;
                              int daysBetween =
                                  DateTime.now().difference(startDate).inDays;
                              for (int i = 0; i < daysBetween + 1; i++) {
                                startDate.add(Duration(days: i));
                                int year =
                                    startDate.add(Duration(days: i)).year;
                                int month =
                                    startDate.add(Duration(days: i)).month;
                                int day = startDate.add(Duration(days: i)).day;
                                datasets = <DateTime, int>{
                                  DateTime(year, month, day): 1
                                };
                              }

                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                width: double.infinity,
                                decoration: decorator.copyWith(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onLongPress: () {
                                            setState(() {
                                              isButtonPressed =
                                                  !isButtonPressed;
                                              habitCompleted = 0;
                                            });
                                          },
                                          child: Container(
                                              height: 60,
                                              width: 60,
                                              decoration: isButtonPressed
                                                  ? decorator
                                                      .copyWith(boxShadow: [
                                                      BoxShadow(
                                                          color: Colors
                                                              .transparent,
                                                          offset: Offset(0, 0)),
                                                      BoxShadow(
                                                          color: Colors
                                                              .transparent,
                                                          offset: Offset(0, 0)),
                                                    ])
                                                  : decorator.copyWith(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      color: Theme.of(context)
                                                          .backgroundColor),
                                              child: Center(
                                                  child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: Color(
                                                        habitItem[index]
                                                            .color!)),
                                              ))),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              habitItem[index].name!,
                                              style: TextStyle(
                                                fontSize: 19,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(habitItem[index].routine ==
                                                            'Anytime' ||
                                                        habitItem[index]
                                                                .routine ==
                                                            'Morning'
                                                    ? Icons.sunny
                                                    : habitItem[index]
                                                                .routine ==
                                                            'Afternoon'
                                                        ? Icons.cloud
                                                        : habitItem[index]
                                                                    .routine ==
                                                                'Evening'
                                                            ? FontAwesomeIcons
                                                                .cloudSun
                                                            : habitItem[index]
                                                                        .routine ==
                                                                    'Night'
                                                                ? FontAwesomeIcons
                                                                    .moon
                                                                : Icons.sunny),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  habitItem[index].routine!,
                                                  style: GoogleFonts.prompt(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    HeatMap(
                                      startDate: habitItem[index].reminder,
                                      datasets: datasets,
                                      colorMode: ColorMode.opacity,
                                      showText: false,
                                      scrollable: true,
                                      colorsets: {
                                        0: Color(habitItem[index].color!)
                                            .withOpacity(0.1),
                                        1: Color(habitItem[index].color!)
                                      },
                                      onClick: (value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text(value.toString())));
                                      },
                                    )
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              );
                            },
                            itemCount: listLength,
                          ),
                        ],
                      ),
                    )
                  : Column(
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
                                child:
                                    Lottie.asset('assets/images/habit.json')),
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
                                        color:
                                            Theme.of(context).backgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(30))),
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
                    );
            }),
          ),
        ),
      ),
    );
  }
}
