import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({Key? key}) : super(key: key);

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
      child: Center(
        child: RotatedBox(
          quarterTurns: 3,
          child: Center(
            child: Icon(
              Icons.send,
              color: Colors.black54,
              size: 50,
            ),
          ),
        ),
      ),
      height: 100,
      width: 100,
      decoration: decorator.copyWith(
          color: Theme.of(context).backgroundColor,
          border: Border.all(width: 10, color: Colors.black54),
          shape: BoxShape.circle),
    );
  }
}
