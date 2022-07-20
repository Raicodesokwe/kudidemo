import 'package:flutter/cupertino.dart';
import 'package:kudidemo/models/task_model.dart';

class TaskProvider with ChangeNotifier {
  final List<TaskModel> _tasks = [];
  List<TaskModel> get tasks {
    return [..._tasks];
  }

  void add(TaskModel task) {
    _tasks.add(task);
    notifyListeners();
  }
}
