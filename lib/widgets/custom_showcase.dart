import 'package:flutter/material.dart';

import 'package:showcaseview/showcaseview.dart';

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
    return Showcase(
      key: globalKey,
      description: description,
      showcaseBackgroundColor: Colors.black,
      contentPadding: const EdgeInsets.all(12),
      child: child,
      descTextStyle: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
    );
  }
}
