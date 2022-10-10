import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class NeonButton extends StatelessWidget {
  const NeonButton({Key? key}) : super(key: key);

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

    Size size = MediaQuery.of(context).size;
    return Container(
      height: 100,
      width: 100,
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
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.green.withAlpha(225),
                blurRadius: 45,
                spreadRadius: 15,
                offset: Offset(0, 0))
          ],
          gradient: LinearGradient(
              colors: [Colors.green, Colors.greenAccent],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft),
          border: Border.all(
              width: 10,
              color: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .color!
                  .withOpacity(0.5)),
          shape: BoxShape.circle),
    );
  }
}
