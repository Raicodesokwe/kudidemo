import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/pages/signin.dart';
import 'package:kudidemo/pages/signup.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fadeAnimation;
  late AnimationController controllerTwo;
  late Animation<double> fadeAnimationTwo;
  late AnimationController controllerThree;
  late Animation<double> fadeAnimationThree;
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(controller);

    controllerTwo =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    fadeAnimationTwo = Tween(begin: 0.0, end: 1.0).animate(controllerTwo);

    controllerThree =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    fadeAnimationThree = Tween(begin: 0.0, end: 1.0).animate(controllerThree);
    scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 550),
    );
    scaleAnimation =
        CurvedAnimation(parent: scaleController, curve: Curves.elasticInOut);
    Future.delayed(Duration(seconds: 1), () {
      controller.forward();
    });

    Future.delayed(Duration(seconds: 2), () {
      controllerTwo.forward();
    });
    Future.delayed(Duration(seconds: 3), () {
      controllerThree.forward().then((value) => scaleController.forward());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    controllerTwo.dispose();
    controllerThree.dispose();
    scaleController.dispose();
    super.dispose();
  }

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
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(bottom: size.height * 0.04),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              FadeTransition(
                opacity: fadeAnimation,
                child: Center(
                  child: Container(
                      // padding: const EdgeInsets.all(10),
                      decoration: decorator.copyWith(
                        color: Theme.of(context).backgroundColor,
                      ),
                      width: size.width * 0.3,
                      child: Image.asset('assets/images/plogo.png')),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              FadeTransition(
                opacity: fadeAnimationTwo,
                child: Center(
                    child: Text(
                  'Hi there',
                  style: TextStyle(fontSize: 25),
                )),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              FadeTransition(
                opacity: fadeAnimationThree,
                child: Center(
                    child: Text(
                  'Plan it has got you covered',
                  style: TextStyle(fontSize: 20),
                )),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              FadeTransition(
                opacity: fadeAnimationThree,
                child: Center(
                  child: Text(
                    'We focus on improving',
                    style: GoogleFonts.prompt(
                        fontWeight: FontWeight.w600, color: Colors.black54),
                  ),
                ),
              ),
              FadeTransition(
                opacity: fadeAnimationThree,
                child: Center(
                  child: Text(
                    'your productivity and wellness',
                    style: GoogleFonts.prompt(
                        fontWeight: FontWeight.w600, color: Colors.black54),
                  ),
                ),
              ),
              Spacer(),
              ScaleTransition(
                scale: scaleAnimation,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignUpScreen()));
                  },
                  child: Container(
                    height: 70,
                    child: Center(
                      child: Center(
                        child: Text(
                          'Hi,let me in!',
                          style: GoogleFonts.prompt(
                              fontSize: 17, color: Colors.white),
                        ),
                      ),
                    ),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Center(
                  child: ScaleTransition(
                scale: scaleAnimation,
                child: TextButton(
                    style: TextButton.styleFrom(primary: Colors.black54),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SigninScreen()));
                    },
                    child: Text(
                      'Already have an account',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 16),
                    )),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
