import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kudidemo/services/notification_service.dart';
import 'package:kudidemo/widgets/task_modal.dart';
import 'package:provider/provider.dart';

import '../models/task_model.dart';
import '../pages/edit_task.dart';
import '../pages/timer_widget.dart';
import '../providers/task_provider.dart';
import '../utils/utils.dart';
import 'icon_circle.dart';

class TaskList extends StatelessWidget {
  final int index;
  final TaskModel taskItem;
  const TaskList({Key? key, required this.taskItem, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // DateTime date = DateFormat.jm().parse(Utils.toDate(taskItem.from!));
    // var myTime = DateFormat("HH:mm").format(date);

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
    final deleteTask = Provider.of<TaskProvider>(context);
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Theme.of(context).backgroundColor,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          taskItem.isComplete == true
                              ? Container()
                              : ListTile(
                                  onTap: () {
                                    final task = TaskModel(
                                        id: taskItem.id,
                                        name: taskItem.name,
                                        from: taskItem.from,
                                        to: taskItem.to,
                                        subtask: taskItem.subtask,
                                        notes: taskItem.notes,
                                        color: taskItem.color,
                                        reminder: taskItem.reminder,
                                        repeat: taskItem.repeat,
                                        isComplete: true);
                                    final taskProvider =
                                        Provider.of<TaskProvider>(context,
                                            listen: false);
                                    taskProvider.changeTask(task);

                                    Navigator.of(context).pop();
                                  },
                                  leading: IconCircle(
                                    icon: Icons.check,
                                  ),
                                  title: Text(
                                    'Mark as done',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .color,
                                        fontFamily: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .fontFamily),
                                  ),
                                ),
                          taskItem.isComplete == true
                              ? Container()
                              : SizedBox(
                                  height: 10,
                                ),
                          taskItem.isComplete == true
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Divider(),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          taskItem.isComplete == true
                              ? Container()
                              : ListTile(
                                  leading: IconCircle(
                                    icon: Icons.timer,
                                  ),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => TimerWidget(
                                                  hourlyRate:
                                                      taskItem.hourlyRate,
                                                  task: taskItem.name,
                                                  color: Color(taskItem.color!),
                                                )));
                                  },
                                  title: Text(
                                    'Start timer',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .color,
                                        fontFamily: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .fontFamily),
                                  ),
                                ),
                          taskItem.isComplete == true
                              ? Container()
                              : SizedBox(
                                  height: 10,
                                ),
                          taskItem.isComplete == true
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Divider(),
                                ),
                          taskItem.isComplete == true
                              ? Container()
                              : SizedBox(
                                  height: 10,
                                ),
                          taskItem.isComplete == true
                              ? Container()
                              : ListTile(
                                  leading: IconCircle(
                                    icon: Icons.edit,
                                  ),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => EditTask(
                                                  task: taskItem,
                                                )));
                                  },
                                  title: Text(
                                    'Edit task',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .color,
                                        fontFamily: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .fontFamily),
                                  ),
                                ),
                          taskItem.isComplete == true
                              ? Container()
                              : SizedBox(
                                  height: 10,
                                ),
                          taskItem.isComplete == true
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Divider(),
                                ),
                          taskItem.isComplete == true
                              ? Container()
                              : SizedBox(
                                  height: 10,
                                ),
                          ListTile(
                            leading: IconCircle(
                              icon: Icons.delete,
                            ),
                            onTap: () {
                              deleteTask.removeTask(taskItem);
                              Navigator.of(context).pop();
                            },
                            title: Text(
                              'Delete',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .color,
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .fontFamily),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    });
              },
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.watch,
                              color: taskItem.isComplete == true
                                  ? Colors.black38
                                  : Colors.black54,
                            ),
                            Text(
                              Utils.toDay(taskItem.from!),
                              style: TextStyle(
                                  fontSize: 10,
                                  color: taskItem.isComplete == true
                                      ? Colors.black38
                                      : Colors.black54),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              Utils.toTime(taskItem.from!),
                              style: TextStyle(
                                  fontSize: 10,
                                  color: taskItem.isComplete == true
                                      ? Colors.black38
                                      : Colors.black54),
                            ),
                            Text(
                              '-',
                              style: TextStyle(
                                  color: taskItem.isComplete == true
                                      ? Colors.black38
                                      : Colors.black54),
                            ),
                            Text(
                              Utils.toTime(taskItem.to!),
                              style: TextStyle(
                                  fontSize: 10,
                                  color: taskItem.isComplete == true
                                      ? Colors.black38
                                      : Colors.black54),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          taskItem.name!,
                          style: TextStyle(
                              fontSize: 19,
                              color: taskItem.isComplete == true
                                  ? Colors.black.withOpacity(0.3)
                                  : Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        taskItem.subtask != ''
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: taskItem.isComplete == true
                                            ? Colors.black38
                                            : Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    taskItem.subtask!,
                                    style: GoogleFonts.prompt(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: taskItem.isComplete == true
                                            ? Colors.black38
                                            : Colors.black.withOpacity(0.7)),
                                  ),
                                ],
                              )
                            : Container(),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          taskItem.notes!,
                          style: GoogleFonts.prompt(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.7)),
                        ),
                      ],
                    ),
                    decoration: decorator.copyWith(
                        boxShadow: taskItem.isComplete == true
                            ? [
                                BoxShadow(
                                    color: Colors.transparent,
                                    offset: Offset(0, 0)),
                                BoxShadow(
                                    color: Colors.transparent,
                                    offset: Offset(0, 0)),
                              ]
                            : null,
                        color: taskItem.isComplete == true
                            ? Color(taskItem.color!).withOpacity(0.5)
                            : Color(taskItem.color!),
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  taskItem.isComplete == true
                      ? Positioned(
                          right: 10,
                          top: 20,
                          child: Chip(
                            elevation: 7,
                            label: Text(
                              'Complete',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .fontFamily),
                            ),
                            backgroundColor: Color(taskItem.color!),
                          ))
                      : Container()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
