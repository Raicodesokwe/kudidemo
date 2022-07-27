import 'package:flutter/material.dart';
import 'package:kudidemo/pages/finances_page.dart';
import 'package:kudidemo/pages/group_task.dart';
import 'package:kudidemo/pages/habits_page.dart';
import 'package:kudidemo/pages/journal_page.dart';
import 'package:kudidemo/pages/task_view.dart';

import 'image_modal.dart';

class TaskModal extends StatelessWidget {
  const TaskModal({
    Key? key,
    required this.themeData,
  }) : super(key: key);

  final bool themeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => TaskView()));
            },
            child: ImageModal(
              themeData: themeData,
              image: "assets/images/tasks.png",
              task: 'Tasks',
            ),
          ),
        ),
        GestureDetector(
          onTap: (() => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HabitsPage()))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ImageModal(
              themeData: themeData,
              image: "assets/images/habits.png",
              task: 'Habits',
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => FinancesPage()));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ImageModal(
              themeData: themeData,
              image: "assets/images/finances.png",
              task: 'Finances',
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => JournalPage()));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ImageModal(
              themeData: themeData,
              image: "assets/images/journal.png",
              task: 'Journal',
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => GroupTask()));
            },
            child: ImageModal(
              themeData: themeData,
              image: "assets/images/group.png",
              task: 'Group tasks',
            ),
          ),
        ),
      ],
    );
  }
}
