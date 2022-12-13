import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/models/habits_model.dart';
import 'package:kudidemo/navbar/navbar.dart';
import 'package:kudidemo/providers/habits_provider.dart';
import 'package:kudidemo/utils/utils.dart';
import 'package:kudidemo/widgets/circle_button.dart';
import 'package:kudidemo/widgets/dailygoal_overlay.dart';
import 'package:kudidemo/widgets/icon_circle.dart';
import 'package:kudidemo/widgets/oval_container.dart';
import 'package:kudidemo/widgets/oval_icon_container.dart';
import 'package:kudidemo/widgets/repeat_overlay.dart';
import 'package:kudidemo/widgets/routine_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../providers/color_provider.dart';
import '../providers/theme_provider.dart';
import '../services/notification_service.dart';
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
        final habit = HabitsModel(
            id: Random().nextInt(10000),
            name: habitsNameController.text,
            color: color.value,
            reminder: selectedTime,
            repeat: repeat,
            days: days,
            complete: complete,
            dailyGoal: count,
            routine: routine);
        final habitProvider =
            Provider.of<HabitsProvider>(context, listen: false);
        habitProvider.addHabits(habit).then((value) {
          habitProvider.reset();
          habitsNameController.clear();
        });
        inputWidget = false;
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
        floatingActionButton: inputWidget
            ? Theme(
                data: Theme.of(context).copyWith(
                    floatingActionButtonTheme: FloatingActionButtonThemeData(
                        extendedSizeConstraints: BoxConstraints.tightFor(
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
                      inputWidget = true;
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
            child: FutureBuilder(
                future: Provider.of<HabitsProvider>(context, listen: false)
                    .getHabits(),
                builder: (context, snapshot) {
                  return Consumer<HabitsProvider>(
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
                                          color:
                                              Color.fromARGB(255, 92, 202, 96),
                                          blurRadius: 8),
                                      Shadow(
                                          color:
                                              Color.fromARGB(255, 92, 202, 96),
                                          blurRadius: 10),
                                      Shadow(
                                          color:
                                              Color.fromARGB(255, 92, 202, 96),
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
                                            color: color,
                                            shape: BoxShape.circle),
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
                      ),
                      builder: (context, notifier, child) {
                        final listLength = notifier.habits.length;
                        final habitItem = notifier.habits;

                        if (notifier.habits.isEmpty || inputWidget == true) {
                          return child!;
                        }
                        return Padding(
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
                                                child: Icon(FontAwesomeIcons
                                                    .handPointUp),
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
                                                  Icon(FontAwesomeIcons
                                                      .exclamation),
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
                                                  Icon(FontAwesomeIcons
                                                      .exclamation),
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
                                      color:
                                          Theme.of(context).backgroundColor)),
                              SizedBox(
                                height: 20,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  // if (habitItem[index].repeat != false) {
                                  //   NotifyService
                                  //       .showDailyScheduledNotification(
                                  //           id: habitItem[index].id,
                                  //           scheduledDate:
                                  //               habitItem[index].reminder!,
                                  //           body: habitItem[index].name,
                                  //           title: 'Reminder');
                                  // }
                                  if (notifier.today.hour == 17 &&
                                      notifier.today.minute == 52 &&
                                      notifier.today.second == 0) {
                                    // incompleteList = habitItem[index].days!;
                                    print('object');
                                    // incompleteList.add('incomplete');

                                    // final habit = HabitsModel(
                                    //     id: habitItem[index].id,
                                    //     name: habitItem[index].name,
                                    //     color: habitItem[index].color,
                                    //     reminder: habitItem[index].reminder,
                                    //     repeat: habitItem[index].repeat,
                                    //     days: incompleteList,
                                    //     complete: habitItem[index].complete,
                                    //     dailyGoal: habitItem[index].dailyGoal,
                                    //     routine: habitItem[index].routine);
                                    // final habitProvider =
                                    //     Provider.of<HabitsProvider>(context,
                                    //         listen: false);
                                    // habitProvider
                                    //     .changeHabit(habit)
                                    //     .then((value) => habitProvider.reset());
                                  } else if (notifier.today.hour == 0 &&
                                      notifier.today.minute == 0 &&
                                      notifier.today.second == 0 &&
                                      habitItem[index].complete == true) {
                                    incompleteList = habitItem[index].days!;

                                    incompleteList.add('incomplete');

                                    final habit = HabitsModel(
                                        id: habitItem[index].id,
                                        name: habitItem[index].name,
                                        color: habitItem[index].color,
                                        reminder: habitItem[index].reminder,
                                        repeat: habitItem[index].repeat,
                                        days: habitItem[index].days,
                                        complete: false,
                                        dailyGoal: habitItem[index].dailyGoal,
                                        routine: habitItem[index].routine);
                                    final habitProvider =
                                        Provider.of<HabitsProvider>(context,
                                            listen: false);
                                    habitProvider
                                        .changeHabit(habit)
                                        .then((value) => habitProvider.reset());
                                  }
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 15),
                                          child: GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .backgroundColor,
                                                  isScrollControlled: true,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  context: context,
                                                  builder: (context) {
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 12),
                                                      child: ListTile(
                                                        onTap: () {
                                                          notifier.removeHabit(
                                                              habitItem[index]);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        leading: IconCircle(
                                                          icon: Icons.delete,
                                                        ),
                                                        title: Text(
                                                          'Delete',
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .color,
                                                              fontFamily: Theme
                                                                      .of(context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .fontFamily),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 10),
                                              width: double.infinity,
                                              decoration: decorator.copyWith(
                                                  color: Theme.of(context)
                                                      .backgroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onLongPress: habitItem[
                                                                        index]
                                                                    .complete ==
                                                                true
                                                            ? () {}
                                                            : () {
                                                                listItem =
                                                                    habitItem[
                                                                            index]
                                                                        .days!;
                                                                listItem.add(
                                                                    'tile');
                                                                final habit = HabitsModel(
                                                                    id: habitItem[index]
                                                                        .id,
                                                                    name: habitItem[index]
                                                                        .name,
                                                                    color: habitItem[
                                                                            index]
                                                                        .color,
                                                                    reminder: habitItem[
                                                                            index]
                                                                        .reminder,
                                                                    repeat: habitItem[
                                                                            index]
                                                                        .repeat,
                                                                    days:
                                                                        listItem,
                                                                    complete:
                                                                        true,
                                                                    dailyGoal: habitItem[
                                                                            index]
                                                                        .dailyGoal,
                                                                    routine: habitItem[
                                                                            index]
                                                                        .routine);
                                                                final habitProvider =
                                                                    Provider.of<
                                                                            HabitsProvider>(
                                                                        context,
                                                                        listen:
                                                                            false);
                                                                habitProvider
                                                                    .changeHabit(
                                                                        habit)
                                                                    .then((value) =>
                                                                        habitProvider
                                                                            .reset());
                                                              },
                                                        child: Container(
                                                            height: 60,
                                                            width: 60,
                                                            decoration: habitItem[
                                                                        index]
                                                                    .complete!
                                                                ? decorator
                                                                    .copyWith(
                                                                        boxShadow: [
                                                                        BoxShadow(
                                                                            color:
                                                                                Colors.transparent,
                                                                            offset: Offset(0, 0)),
                                                                        BoxShadow(
                                                                            color:
                                                                                Colors.transparent,
                                                                            offset: Offset(0, 0)),
                                                                      ])
                                                                : decorator.copyWith(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    color: Theme.of(
                                                                            context)
                                                                        .backgroundColor),
                                                            child: Center(
                                                                child:
                                                                    Container(
                                                              height: 40,
                                                              width: 40,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6),
                                                                  color: Color(
                                                                      habitItem[
                                                                              index]
                                                                          .color!)),
                                                            ))),
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            habitItem[index]
                                                                .name!,
                                                            style: TextStyle(
                                                              fontSize: 19,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(habitItem[index]
                                                                              .routine ==
                                                                          'Anytime' ||
                                                                      habitItem[index]
                                                                              .routine ==
                                                                          'Morning'
                                                                  ? Icons.sunny
                                                                  : habitItem[index]
                                                                              .routine ==
                                                                          'Afternoon'
                                                                      ? Icons
                                                                          .cloud
                                                                      : habitItem[index].routine ==
                                                                              'Evening'
                                                                          ? FontAwesomeIcons
                                                                              .cloudSun
                                                                          : habitItem[index].routine == 'Night'
                                                                              ? FontAwesomeIcons.moon
                                                                              : Icons.sunny),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                habitItem[index]
                                                                    .routine!,
                                                                style: GoogleFonts
                                                                    .prompt(),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(FontAwesomeIcons
                                                                  .bullseye),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                habitItem[index]
                                                                            .dailyGoal ==
                                                                        1
                                                                    ? '${habitItem[index].dailyGoal} time per day'
                                                                    : '${habitItem[index].dailyGoal} times per day',
                                                                style: GoogleFonts
                                                                    .prompt(),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                      '${notifier.habits[index].days!.length}'),
                                                  Wrap(
                                                    spacing: 5,
                                                    runSpacing: 15,
                                                    alignment:
                                                        WrapAlignment.start,
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .start,
                                                    direction: Axis.horizontal,
                                                    runAlignment:
                                                        WrapAlignment.start,
                                                    verticalDirection:
                                                        VerticalDirection.down,
                                                    clipBehavior: Clip.none,
                                                    children: List.generate(
                                                        notifier
                                                            .habits[index]
                                                            .days!
                                                            .length, (index) {
                                                      return habitItem[index]
                                                              .days!
                                                              .isEmpty
                                                          ? Container()
                                                          : habitItem[index]
                                                                          .days![
                                                                      index] ==
                                                                  'tile'
                                                              ? Container(
                                                                  height: 20,
                                                                  width: 20,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: Color(
                                                                          habitItem[index]
                                                                              .color!)),
                                                                )
                                                              : habitItem[index]
                                                                              .days![
                                                                          index] ==
                                                                      'incomplete'
                                                                  ? Container(
                                                                      height:
                                                                          20,
                                                                      width: 20,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              5),
                                                                          color:
                                                                              Color(habitItem[index].color!).withOpacity(0.4)),
                                                                    )
                                                                  : Container();
                                                    }),
                                                  )
                                                ],
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: listLength,
                              ),
                            ],
                          ),
                        );
                      });
                }),
          ),
        ),
      ),
    );
  }
}
