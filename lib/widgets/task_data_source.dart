import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/task_model.dart';

class TaskDataSource extends CalendarDataSource {
  TaskDataSource(List<TaskModel> tasks) {
    appointments = tasks;
  }
  TaskModel getTask(int index) => appointments![index] as TaskModel;

  @override
  DateTime getStartTime(int index) => getTask(index).from!;

  @override
  DateTime getEndTime(int index) => getTask(index).to!;

  @override
  String getSubject(int index) => getTask(index).name!;

  @override
  Color getColor(int index) => Color(getTask(index).color!);
}
