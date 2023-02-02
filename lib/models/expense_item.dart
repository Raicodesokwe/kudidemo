import 'dart:io';

import 'package:hive/hive.dart';
part 'expense_item.g.dart';

@HiveType(typeId: 4)
class ExpenseItem extends HiveObject {
  @HiveField(0)
  final String? category;
  @HiveField(1)
  final double? amount;
  @HiveField(2)
  final DateTime? date;
  @HiveField(3)
  final String? notes;
  @HiveField(4)
  final String? status;
  @HiveField(5)
  final File? image;
  ExpenseItem(
      {this.category,
      this.status,
      this.amount,
      this.date,
      this.notes,
      this.image});
}
