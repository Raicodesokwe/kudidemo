import 'package:flutter/material.dart';
import 'package:kudidemo/pages/homepage.dart';
import 'package:showcaseview/showcaseview.dart';

class ShowCaseWidgetBuilder extends StatelessWidget {
  const ShowCaseWidgetBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowCaseWidget(
          autoPlay: true,
          autoPlayDelay: Duration(seconds: 3),
          builder: Builder(
            builder: (context) => HomePage(),
          )),
    );
  }
}
