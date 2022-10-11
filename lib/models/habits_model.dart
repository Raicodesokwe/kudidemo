class HabitsModel {
  final int? id;
  final String? name;
  final int? color;
  final int? dailyGoal;
  final String? repeat;
  final String? routine;
  final DateTime? reminder;
  HabitsModel(
      {this.color,
      this.dailyGoal,
      this.id,
      this.name,
      this.repeat,
      this.reminder,
      this.routine});
}
