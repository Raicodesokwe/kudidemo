class RepeatModel {
  final String repeat;
  RepeatModel({required this.repeat});
}

List<RepeatModel> repeatList = [
  RepeatModel(repeat: 'None'),
  RepeatModel(repeat: 'Daily'),
  RepeatModel(repeat: 'Weekly'),
  RepeatModel(repeat: 'Monthly'),
];
