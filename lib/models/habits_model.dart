import 'package:hive/hive.dart';
part 'habits_model.g.dart';

@HiveType(typeId: 1)
class HabitsModel extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final int? color;
  @HiveField(3)
  final int? dailyGoal;
  @HiveField(4)
  final bool? repeat;
  @HiveField(5)
  final String? routine;
  @HiveField(6)
  final DateTime? reminder;
  @HiveField(7)
  final List? days;
  @HiveField(8)
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
