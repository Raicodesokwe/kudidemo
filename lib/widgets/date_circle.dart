import 'package:flutter/material.dart';

class DateCircle extends StatelessWidget {
  final String day;
  final bool alldays;
  final bool dayselected;
  const DateCircle(
      {Key? key,
      required this.day,
      required this.alldays,
      required this.dayselected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final decorator = BoxDecoration(boxShadow: [
      BoxShadow(
          color: Theme.of(context).cardColor,
          offset: Offset(5, 5),
          blurRadius: 15,
          spreadRadius: 5),
      BoxShadow(
        spreadRadius: 1,
        color: Theme.of(context).canvasColor,
        offset: Offset(-5, -5),
        blurRadius: 15,
      )
    ]);
    return Container(
      height: 50,
      width: 50,
      child: Center(
        child: Text(
          day,
          style: TextStyle(
              fontSize: 12,
              fontFamily: Theme.of(context).textTheme.bodyText2!.fontFamily,
              color: Theme.of(context).textTheme.bodyText2!.color),
        ),
      ),
      decoration: decorator.copyWith(
          shape: BoxShape.circle,
          color: alldays && dayselected
              ? Colors.green
              : Theme.of(context).backgroundColor),
    );
  }
}
