import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/pages/day_rating.dart';
import 'package:kudidemo/pages/finances_page.dart';
import 'package:kudidemo/pages/group_task.dart';
import 'package:kudidemo/pages/habits_page.dart';
import 'package:kudidemo/pages/journal_page.dart';
import 'package:kudidemo/pages/task_view.dart';
import 'package:kudidemo/services/auth_service.dart';

import 'image_modal.dart';

class TaskModal extends StatelessWidget {
  const TaskModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => TaskView()));
                  },
                  child: ImageModal(
                    image: "assets/images/tasks.png",
                    task: 'Tasks',
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HabitsPage()));
                  },
                  child: ImageModal(
                    task: 'Habits',
                    image: "assets/images/habits.png",
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FinancesPage()));
                  },
                  child: ImageModal(
                    task: 'Finances',
                    image: "assets/images/finances.png",
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => JournalPage()));
                  },
                  child: ImageModal(
                    task: 'Journal',
                    image: "assets/images/journal.png",
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => GroupTask()));
                  },
                  child: ImageModal(
                    task: 'Group tasks',
                    image: "assets/images/group.png",
                  ),
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: GoogleFonts.prompt(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.black),
                ),
              ),
            ),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 5),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => TaskView()));
                    AuthService.signOut(context);
                  },
                  child: ImageModal(
                    image: "assets/images/tasks.png",
                    task: 'Tasks',
                  ),
                ),
              ),
              GestureDetector(
                onTap: (() => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HabitsPage()))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ImageModal(
                    image: "assets/images/habits.png",
                    task: 'Habits',
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => FinancesPage()));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ImageModal(
                    image: "assets/images/finances.png",
                    task: 'Finances',
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DayRating()));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ImageModal(
                    image: "assets/images/journal.png",
                    task: 'Journal',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => GroupTask()));
                  },
                  child: ImageModal(
                    image: "assets/images/group.png",
                    task: 'Group tasks',
                  ),
                ),
              ),
            ],
          );
  }
}
