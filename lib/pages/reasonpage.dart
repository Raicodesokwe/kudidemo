import 'package:flutter/material.dart';
import 'package:kudidemo/widgets/back_arrow.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class ReasonPage extends StatelessWidget {
  const ReasonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            BackArrow(decorator: decorator, themeData: themeData),
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              'What made your day HAPPY?',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
