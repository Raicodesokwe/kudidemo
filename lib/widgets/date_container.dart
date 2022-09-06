import 'package:flutter/material.dart';

class DateContainer extends StatelessWidget {
  const DateContainer({
    Key? key,
    required this.decorator,
    required this.day,
    required this.date,
  }) : super(key: key);

  final BoxDecoration decorator;

  final String? day;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorator.copyWith(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(10.0)),
      height: 60,
      width: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(day!), Text(date!)],
      ),
    );
  }
}
