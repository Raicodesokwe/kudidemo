import 'dart:io';
import 'dart:typed_data';

import 'package:hive/hive.dart';
part 'expense_item.g.dart';

@HiveType(typeId: 4)
class ExpenseItem extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final double? amount;
  @HiveField(2)
  final DateTime? date;
  @HiveField(3)
  final String? notes;
  @HiveField(4)
  final String? status;
  @HiveField(5)
  final Uint8List? image;
  @HiveField(6)
  final String? category;
  ExpenseItem(
      {this.category,
      this.status,
      this.amount,
      this.date,
      this.notes,
      this.id,
      this.image});
}
