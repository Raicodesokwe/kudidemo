class TaskModel {
  final String? name;
  final String? category;
  final DateTime? from;
  final DateTime? to;
  final String? notes;
  final bool? isRepeatable;

  TaskModel(
      {this.name,
      this.category,
      this.from,
      this.to,
      this.notes,
      this.isRepeatable});
}
