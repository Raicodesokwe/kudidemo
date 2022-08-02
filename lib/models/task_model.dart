import 'package:flutter/material.dart';

class TaskModel {
  final String? name;
  final Color? color;
  final DateTime? from;
  final DateTime? to;
  final String? notes;

  TaskModel({this.name, this.from, this.to, this.notes, this.color});
}
