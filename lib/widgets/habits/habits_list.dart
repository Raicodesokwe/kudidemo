import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../data/habit_database.dart';
import '../../pages/habits/edit_habit.dart';
import '../../providers/habits_provider.dart';
import '../../services/notification_service.dart';
import '../back_arrow.dart';
import '../monthly_summary.dart';

class HabitsList extends StatefulWidget {
  const HabitsList({Key? key}) : super(key: key);

  @override
  State<HabitsList> createState() => _HabitsListState();
}

class _HabitsListState extends State<HabitsList> {
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
  }

  void deleteTapped(int index) {
    setState(() {
      db.habits.removeAt(index);
    });
    db.updateDatabase();
  }

  void checkBoxTapped(int index) {
    setState(() {
      db.habits[index][6] = true;
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    void settingsTapped(int index) {
      print('jesu jesu');
      final name = Provider.of<HabitsProvider>(context, listen: false).editName;
      if (name != '') {
        setState(() {
          db.habits[index][1] = name;
        });

        Navigator.of(context).pop();
        db.updateDatabase();
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
    return SingleChildScrollView(
      child: Padding(
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
                              color: Theme.of(context).backgroundColor),
                          child: Center(
                            child: Container(
                              height: 40,
                              width: 40,
                              child: Icon(FontAwesomeIcons.handPointUp),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red.withOpacity(0.1)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Long press button to\nmark task as complete',
                            ),
                            Row(
                              children: [
                                Icon(FontAwesomeIcons.exclamation),
                                Text(
                                  'It takes an average of 66 days for a\nnew behaviour to become automatic',
                                  style: GoogleFonts.prompt(fontSize: 11),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(FontAwesomeIcons.exclamation),
                                Text(
                                  'It takes an average of 10000 hours to \nbecome an expert at something',
                                  style: GoogleFonts.prompt(fontSize: 11),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: decorator.copyWith(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).backgroundColor)),
            MonthlySummary(
                datasets: db.heatMapDataSet,
                startDate: _myBox.get("START_DATE")),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final habitItem = db.habits;
                if (habitItem[index][4] != false) {
                  NotifyService.showDailyScheduledNotification(
                      id: habitItem[index][0],
                      scheduledDate: habitItem[index][3],
                      body: habitItem[index][1],
                      title: 'Reminder');
                }

                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Slidable(
                          endActionPane:
                              ActionPane(motion: StretchMotion(), children: [
                            SlidableAction(
                              onPressed: (context) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditHabit(
                                          habitName: habitItem[index][1],
                                          onSave: () => settingsTapped(index),
                                        )));
                              },
                              backgroundColor: Colors.grey.shade800,
                              icon: Icons.settings,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                deleteTapped(index);
                              },
                              backgroundColor: Colors.red.shade400,
                              icon: Icons.delete,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ]),
                          child: Container(
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
                                      onLongPress: () => checkBoxTapped(index),
                                      child: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: habitItem[index][6]
                                              ? decorator.copyWith(boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.transparent,
                                                      offset: Offset(0, 0)),
                                                  BoxShadow(
                                                      color: Colors.transparent,
                                                      offset: Offset(0, 0)),
                                                ])
                                              : decorator.copyWith(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Theme.of(context)
                                                      .backgroundColor),
                                          child: Center(
                                              child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: Color(
                                                    habitItem[index][2]!)),
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
                                          habitItem[index][1],
                                          style: TextStyle(
                                            fontSize: 19,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(habitItem[index][8] ==
                                                        'Anytime' ||
                                                    habitItem[index][8] ==
                                                        'Morning'
                                                ? Icons.sunny
                                                : habitItem[index][8] ==
                                                        'Afternoon'
                                                    ? Icons.cloud
                                                    : habitItem[index][8] ==
                                                            'Evening'
                                                        ? FontAwesomeIcons
                                                            .cloudSun
                                                        : habitItem[index][8] ==
                                                                'Night'
                                                            ? FontAwesomeIcons
                                                                .moon
                                                            : Icons.sunny),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              habitItem[index][8]!,
                                              style: GoogleFonts.prompt(),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Icon(FontAwesomeIcons.bullseye),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              habitItem[index][7] == 1
                                                  ? '${habitItem[index][7]} time per day'
                                                  : '${habitItem[index][7]} times per day',
                                              style: GoogleFonts.prompt(),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.arrow_back,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color!,
                                    )
                                  ],
                                ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: db.habits.length,
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
