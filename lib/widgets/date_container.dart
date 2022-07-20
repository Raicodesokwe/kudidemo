import 'package:flutter/material.dart';

class DateContainer extends StatelessWidget {
  const DateContainer({
    Key? key,
    required this.decorator,
    required this.themeData,
    required this.day,
    required this.date,
  }) : super(key: key);

  final BoxDecoration decorator;
  final bool themeData;

  final String? day;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorator.copyWith(
          color: themeData ? Colors.grey[300] : Colors.grey[900],
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
      // Text(
      //       '${DateFormat("EEEE").format(now.subtract(Duration(days: 2))).substring(0, 3)}',
      //     ),
      //     Text((now.day - 2).toString())
