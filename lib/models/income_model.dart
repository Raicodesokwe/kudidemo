import 'package:flutter/material.dart';

class IncomeModel {
  final String image;
  final String name;
  final Color color;
  IncomeModel({required this.image, required this.name, required this.color});
}

List<IncomeModel> incomeCategoryList = [
  IncomeModel(
      image: 'assets/images/house.png',
      name: 'Rent',
      color: Colors.orangeAccent),
  IncomeModel(
      image: 'assets/images/freelance.png',
      name: 'Freelance',
      color: Colors.redAccent),
  IncomeModel(
      image: 'assets/images/business.png',
      name: 'Business',
      color: Colors.greenAccent),
  IncomeModel(
      image: 'assets/images/plus.png',
      name: 'Others',
      color: Colors.deepPurpleAccent),
  IncomeModel(
      image: 'assets/images/sponsor.png',
      name: 'Sponsor',
      color: Colors.blueAccent),
  IncomeModel(
      image: 'assets/images/salary.png',
      name: 'Salary',
      color: Colors.pinkAccent),
];
