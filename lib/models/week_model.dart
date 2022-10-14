class WeekModel {
  final String day;
  bool daySelected;
  WeekModel({required this.day, required this.daySelected});
}

List<WeekModel> weekDays = [
  WeekModel(day: 'Mon', daySelected: false),
  WeekModel(day: 'Tue', daySelected: false),
  WeekModel(day: 'Wed', daySelected: false),
  WeekModel(day: 'Thu', daySelected: false),
  WeekModel(day: 'Fri', daySelected: false),
  WeekModel(day: 'Sat', daySelected: false),
  WeekModel(day: 'Sun', daySelected: false),
];
