import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:kudidemo/models/task_model.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks {
    return [..._tasks];
  }

  final String taskHiveBox = 'task-box';
  DateTime? from = DateTime.now();
  DateTime? to = DateTime.now().add(Duration(hours: 1));
  Future<void> addTask(TaskModel task) async {
    Box<TaskModel> box = await Hive.openBox<TaskModel>(taskHiveBox);
    await box.add(task);
    _tasks.add(task);
    _tasks = box.values.toList();
    notifyListeners();
  }

  Future<void> getTasks() async {
    Box<TaskModel> box = await Hive.openBox<TaskModel>(taskHiveBox);
    _tasks = box.values.toList();
    notifyListeners();
  }

  Future<void> removeTask(TaskModel task) async {
    Box<TaskModel> box = await Hive.openBox<TaskModel>(taskHiveBox);
    await box.delete(task.key);
    _tasks = box.values.toList();
    notifyListeners();
  }

  Future<void> changeTask(TaskModel task) async {
    Box box = Hive.box(taskHiveBox);
    box.put("title", "Study Flutter");
    notifyListeners();
  }

  int? reminder = 0;
  String? repeat = '';
  void addTaskDetails(TaskModel task) {
    from = task.from;
    to = task.to;
    reminder = task.reminder;
    repeat = task.repeat;
    notifyListeners();
  }
}
