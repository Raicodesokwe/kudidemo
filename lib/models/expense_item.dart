import 'dart:io';

class ExpenseItem {
  final String? currency;
  final String? category;
  final double? amount;
  final DateTime? date;
  final String? notes;
  final File? image;
  ExpenseItem(
      {this.currency,
      this.category,
      this.amount,
      this.date,
      this.notes,
      this.image});
}
