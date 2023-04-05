import 'package:hive/hive.dart';
part 'budget_model.g.dart';

@HiveType(typeId: 11)
class BudgetModel extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? budgetType;
  @HiveField(3)
  final String? budgetSchedule;
  @HiveField(4)
  final double? amount;

  BudgetModel(
      {this.id, this.name, this.budgetType, this.budgetSchedule, this.amount});
}
