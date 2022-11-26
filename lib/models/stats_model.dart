import 'package:flutter/material.dart';

class StatsModel {
  final String? name;
  final Color? color;
  final String? image;
  StatsModel({
    required this.name,
    required this.color,
    required this.image,
  });
}

List<StatsModel> statsList = [
  StatsModel(name: 'Task', color: Colors.green, image: 'tasks.png'),
  StatsModel(name: 'Habits', color: Colors.pink, image: 'habits.png'),
  StatsModel(name: 'Finances', color: Colors.purple, image: 'finances.png'),
  StatsModel(name: 'Journal', color: Colors.blue, image: 'journal.png'),
  StatsModel(name: 'Timer', color: Colors.orange, image: 'stopwatch.png'),
  StatsModel(name: 'Group tasks', color: Colors.red, image: 'group.png'),
];
