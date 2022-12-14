import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kudidemo/models/billable_model.dart';

import 'package:kudidemo/models/reminder_model.dart';
import 'package:kudidemo/models/repeat_model.dart';
import 'package:kudidemo/models/task_model.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks {
    return [..._tasks];
  }

  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;
  void setDate(DateTime date) => _selectedDate = date;
  List<TaskModel> get eventsOfSelectedDate => _tasks;
  double? hourlyRate = 0;
  final String taskHiveBox = 'task-box';
  DateTime? from = DateTime.now();
  DateTime? to = DateTime.now().add(Duration(hours: 1));
  Future<void> addTask(TaskModel task) async {
    Box<TaskModel> box = await Hive.openBox<TaskModel>(taskHiveBox);
    await box.put(task.id, task);
    // _tasks.add(task);
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
    Box<TaskModel> box = await Hive.openBox<TaskModel>(taskHiveBox);

    await box.put(task.id, task);
    _tasks = box.values.toList();

    notifyListeners();
  }

  int? reminder = 0;
  String? repeat = 'None';
  String? notes = '';
  String? subtask = '';
  void addTaskDetails(TaskModel task) {
    from = task.from;
    to = task.to;
    reminder = task.reminder;
    repeat = task.repeat;

    notifyListeners();
  }

  void addNotes(TaskModel task) {
    notes = task.notes;
    notifyListeners();
  }

  void addSubtask(TaskModel task) {
    subtask = task.subtask;
    notifyListeners();
  }

  void addHourlyRate(TaskModel task) {
    hourlyRate = task.hourlyRate;
    notifyListeners();
  }

  void selectReminder(int reminderindex) {
    reminder = reminderList[reminderindex].reminder;
    notifyListeners();
  }

  void selectRepeat(int repeatindex) {
    repeat = repeatList[repeatindex].repeat;
    notifyListeners();
  }

  bool? complete = false;
  void completeStatus() {
    complete = !complete!;
    notifyListeners();
  }

  List<BillableModel> bills = [];

  void addBillableList(BillableModel bill) {
    bills.add(bill);
    notifyListeners();
  }

  void reset() {
    reminder = 0;
    repeat = 'None';
    notes = '';
    subtask = '';
    from = DateTime.now();
    to = DateTime.now().add(Duration(hours: 1));
    hourlyRate = 0;
  }
}
