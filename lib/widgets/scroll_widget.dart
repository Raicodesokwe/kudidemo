import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/pages/day_rating.dart';
import 'package:kudidemo/pages/group_task.dart';
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.02,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => TaskView()));
            },
            child: TaskWidget(
              size: size,
              decorator: decorator,
              task: 'Task',
              image: "assets/images/tasks.png",
            ),
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
                  color: themeData ? Colors.grey[300] : Colors.grey[900],
                  borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
          SizedBox(width: size.width * 0.06),
        ],
      ),
    );
  }
}
