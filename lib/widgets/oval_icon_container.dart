import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class OvalIconContainer extends StatelessWidget {
  final String text;
  final IconData icon;
  final double size;
  const OvalIconContainer(
      {Key? key, required this.text, required this.icon, required this.size})
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
    return Container(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Row(
            children: [
              Icon(
                icon,
                color: themeData ? Colors.black54 : Colors.white54,
                size: size,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                text,
                style: TextStyle(
                    color: themeData ? Colors.black45 : Colors.white54,
                    fontSize: 10,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        decoration: decorator.copyWith(
            color: themeData ? Colors.grey[300] : Colors.grey[900],
            borderRadius: BorderRadius.circular(30)));
  }
}
