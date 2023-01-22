import 'package:flutter/material.dart';

class CircleAnimation extends StatefulWidget {
  const CircleAnimation({Key? key}) : super(key: key);

  @override
  State<CircleAnimation> createState() => _CircleAnimationState();
}

class _CircleAnimationState extends State<CircleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animationController.forward();
    animationController.repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
        child: Container(
            height: 50,
            width: 50,
            child: Center(child: Icon(Icons.download)),
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            )),
        turns: Tween(begin: 0.0, end: 1.0).animate(animationController));
  }
}
