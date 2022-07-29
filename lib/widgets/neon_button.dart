import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class NeonButton extends StatelessWidget {
  const NeonButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeProvider>(context).darkTheme;
    final BoxDecoration decorator = BoxDecoration(
      boxShadow: themeData
          ? [
              BoxShadow(
                  color: Colors.grey.shade500,
                  offset: Offset(4, 4),
                  blurRadius: 15,
                  spreadRadius: 1),
              BoxShadow(
                spreadRadius: 1,
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 15,
              )
            ]
          : [
              BoxShadow(
                  color: Colors.black,
                  offset: Offset(5, 5),
                  blurRadius: 15,
                  spreadRadius: 5),
              BoxShadow(
                spreadRadius: 1,
                color: Colors.grey.shade800,
                offset: Offset(-4, -4),
                blurRadius: 15,
              )
            ],
    );
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
              color: themeData ? Colors.black54 : Colors.white54,
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
            color: themeData ? Colors.black54 : Colors.white54,
          ),
          shape: BoxShape.circle),
    );
  }
}
