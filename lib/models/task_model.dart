import 'package:hive/hive.dart';
import 'package:kudidemo/models/billable_model.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final int? color;
  @HiveField(3)
  final DateTime? from;
  @HiveField(4)
  final DateTime? to;
  @HiveField(5)
  final String? notes;
  @HiveField(6)
  final String? subtask;
  @HiveField(7)
  final int? reminder;
  @HiveField(8)
  final String? repeat;
  @HiveField(9)
  final bool? isComplete;
  @HiveField(10)
  final double? hourlyRate;
  @HiveField(11)
  final List<BillableModel>? billList;

  TaskModel(
      {this.id,
      this.name,
      this.from,
      this.to,
      this.notes,
      this.color,
      this.reminder,
      this.repeat,
      this.subtask,
      this.hourlyRate,
      this.isComplete,
      this.billList});
}
