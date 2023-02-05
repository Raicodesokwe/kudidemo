import 'package:flutter/material.dart';

class ButtonEdit extends StatelessWidget {
  final IconData icon;
  final String label;
  const ButtonEdit({Key? key, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
        width: size.width * 0.4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(
              width: 5,
            ),
            Text(label)
          ],
        ),
        decoration: decorator.copyWith(
          borderRadius: BorderRadius.circular(12),
          color: Colors.greenAccent,
        ));
  }
}
