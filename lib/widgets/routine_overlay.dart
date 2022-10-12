import 'package:flutter/material.dart';

class RoutineOverlay extends StatefulWidget {
  const RoutineOverlay({Key? key}) : super(key: key);

  @override
  State<RoutineOverlay> createState() => _RoutineOverlayState();
}

class _RoutineOverlayState extends State<RoutineOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
