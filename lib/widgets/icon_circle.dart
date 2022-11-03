import 'package:flutter/material.dart';

class IconCircle extends StatelessWidget {
  final IconData icon;
  const IconCircle({Key? key, required this.icon}) : super(key: key);

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
      height: 70,
      width: 70,
      child: Center(
        child: Icon(
          icon,
          color: Theme.of(context).textTheme.bodyText2!.color,
        ),
      ),
      decoration: decorator.copyWith(
          shape: BoxShape.circle, color: Theme.of(context).backgroundColor),
    );
  }
}
