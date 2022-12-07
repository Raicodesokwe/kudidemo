import 'package:flutter/material.dart';

class HabitsModel {
  final int? id;
  final String? name;
  final int? color;
  final int? dailyGoal;
  final bool? repeat;
  final String? routine;
  final DateTime? reminder;
  final List? days;
  final bool? complete;

  HabitsModel(
      {this.color,
      this.dailyGoal,
      this.id,
      this.name,
      this.repeat,
      this.reminder,
      this.days,
      this.complete,
      this.routine});
}
