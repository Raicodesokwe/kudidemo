import 'package:flutter/material.dart';

class ExpenseModel {
  final String image;
  final String name;
  final Color color;
  ExpenseModel({required this.image, required this.name, required this.color});
}

List<ExpenseModel> expenseList = [
  ExpenseModel(
      image: 'assets/images/enta.png',
      name: 'Entertainment',
      color: Colors.orangeAccent),
  ExpenseModel(
      image: 'assets/images/shopping.png',
      name: 'Shopping',
      color: Colors.redAccent),
  ExpenseModel(
      image: 'assets/images/clothing.png',
      name: 'Clothing',
      color: Colors.greenAccent),
  ExpenseModel(
      image: 'assets/images/insurance.png',
      name: 'Insurance',
      color: Colors.blueAccent),
  ExpenseModel(
      image: 'assets/images/tax.png', name: 'Tax', color: Colors.pinkAccent),
  ExpenseModel(
      image: 'assets/images/health.png',
      name: 'Health',
      color: Colors.purpleAccent),
  ExpenseModel(
      image: 'assets/images/beauty.png',
      name: 'Beauty',
      color: Colors.pinkAccent),
  ExpenseModel(
      image: 'assets/images/gift.png',
      name: 'Gifts',
      color: Colors.yellowAccent),
  ExpenseModel(
      image: 'assets/images/social.png',
      name: 'Social',
      color: Colors.greenAccent),
  ExpenseModel(
      image: 'assets/images/travel.png',
      name: 'Travel',
      color: Colors.blueAccent),
  ExpenseModel(
      image: 'assets/images/education.png',
      name: 'Education',
      color: Colors.redAccent),
  ExpenseModel(
      image: 'assets/images/trustfund.png',
      name: 'Trust fund',
      color: Colors.deepOrangeAccent),
  ExpenseModel(
      image: 'assets/images/plus.png',
      name: 'Others',
      color: Colors.deepPurpleAccent),
  ExpenseModel(
      image: 'assets/images/food.png', name: 'Food', color: Colors.pinkAccent),
  ExpenseModel(
      image: 'assets/images/debt.png',
      name: 'Debt',
      color: Colors.yellowAccent),
];
