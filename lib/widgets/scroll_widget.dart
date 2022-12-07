import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/pages/day_rating.dart';
import 'package:kudidemo/pages/group_task.dart';
import 'package:kudidemo/pages/landing_screen.dart';
import 'package:kudidemo/pages/splash_screen.dart';
import 'package:kudidemo/pages/timer_widget.dart';
import 'package:kudidemo/providers/task_provider.dart';
import 'package:kudidemo/services/auth_service.dart';
import 'package:kudidemo/widgets/task_widget.dart';
import 'package:provider/provider.dart';

import '../pages/finances_page.dart';
import '../pages/habits_page.dart';
import '../pages/journal_page.dart';
import '../pages/task_view.dart';
import '../providers/theme_provider.dart';

class ScrollWidget extends StatelessWidget {
  const ScrollWidget({
    Key? key,
    required this.size,
    required this.decorator,
  }) : super(key: key);

  final Size size;
  final BoxDecoration decorator;

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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.02,
          ),
          GestureDetector(
            onTap: () {
              // AuthService.signOut(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => TaskView()));
            },
            child: Consumer<TaskProvider>(builder: (context, notifier, child) {
              final listLength = notifier.tasks.length;
              return TaskWidget(
                size: size,
                decorator: decorator,
                task: 'Task',
                count: listLength <= 0
                    ? ''
                    : listLength == 1
                        ? '$listLength task'
                        : '$listLength tasks',
                image: "assets/images/tasks.png",
              );
            }),
          ),
          SizedBox(
            width: size.width * 0.04,
          ),
          GestureDetector(
            onTap: (() => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HabitsPage()))),
            child: TaskWidget(
              size: size,
              decorator: decorator,
              task: 'Habits',
              image: "assets/images/habits.png",
            ),
          ),
          SizedBox(
            width: size.width * 0.06,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FinancesPage()));
            },
            child: TaskWidget(
              size: size,
              decorator: decorator,
              task: 'Finances',
              image: "assets/images/finances.png",
            ),
          ),
          SizedBox(
            width: size.width * 0.06,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => DayRating()));
            },
            child: TaskWidget(
              size: size,
              decorator: decorator,
              task: 'Journal',
              image: "assets/images/journal.png",
            ),
          ),
          SizedBox(
            width: size.width * 0.06,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => TimerWidget()));
            },
            child: TaskWidget(
              size: size,
              decorator: decorator,
              task: 'Timer',
              image: "assets/images/stopwatch.png",
            ),
          ),
          SizedBox(
            width: size.width * 0.06,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => GroupTask()));
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    width: 100,
                    child: Image.asset(
                      "assets/images/group.png",
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Text('Group tasks',
                      style: GoogleFonts.prompt(
                          fontSize: 17, fontWeight: FontWeight.w700))
                ],
              ),
              decoration: decorator.copyWith(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
          SizedBox(width: size.width * 0.06),
        ],
      ),
    );
  }
}
