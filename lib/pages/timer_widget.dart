import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/models/task_model.dart';
import 'package:kudidemo/widgets/billable_widget.dart';

import 'package:kudidemo/widgets/pomodoro_widget.dart';

import '../widgets/back_arrow.dart';

class TimerWidget extends StatelessWidget {
  final TaskModel? taskItem;
  final String? task;
  final Color? color;
  final double? hourlyRate;
  TimerWidget({Key? key, this.taskItem, this.task, this.color, this.hourlyRate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // isRunning = _timer == null ? false : _timer!.isActive;
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

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            body: Column(
          children: [
            BackArrow(
              decorator: decorator,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 60,
                decoration: decorator.copyWith(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).backgroundColor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBar(
                      labelColor: Theme.of(context).textTheme.bodyText2!.color,
                      labelStyle: Theme.of(context).textTheme.bodyText2,
                      indicator: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
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
                        ],
                      ),
                      tabs: const [
                        Tab(
                          text: 'Pomodoro',
                        ),
                        Tab(
                          text: 'Billable\ntask',
                        ),
                      ]),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: TabBarView(children: [
                PomodoroWidget(
                  color: color,
                  task: task,
                ),
                BillableWidget(
                  taskItem: taskItem,
                  hourlyRate: hourlyRate,
                  color: color,
                  task: task,
                )
              ]),
            ),
          ],
        )),
      ),
    );
  }
}
