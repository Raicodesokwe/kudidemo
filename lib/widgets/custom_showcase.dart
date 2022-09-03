import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../providers/theme_provider.dart';

class CustomShowcaseWidget extends StatelessWidget {
  final GlobalKey globalKey;
  final Widget child;
  final String description;
  const CustomShowcaseWidget(
      {Key? key,
      required this.globalKey,
      required this.child,
      required this.description})
      : super(key: key);

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
    return Showcase(
      key: globalKey,
      description: description,
      showcaseBackgroundColor: themeData ? Colors.black : Colors.white,
      contentPadding: const EdgeInsets.all(12),
      child: child,
      descTextStyle: TextStyle(
          color: themeData ? Colors.white : Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16),
    );
  }
}
