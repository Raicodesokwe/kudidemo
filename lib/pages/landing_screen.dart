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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    controllerTwo.dispose();
    controllerThree.dispose();
    scaleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      controller.forward();
    });

    Future.delayed(Duration(seconds: 2), () {
      controllerTwo.forward();
    });
    Future.delayed(Duration(seconds: 3), () {
      controllerThree.forward().then((value) => scaleController.forward());
    });
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
                        color: themeData ? Colors.grey[300] : Colors.grey[900],
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
                        fontWeight: FontWeight.w600,
                        color: themeData ? Colors.black54 : Colors.white54),
                  ),
                ),
              ),
              FadeTransition(
                opacity: fadeAnimationThree,
                child: Center(
                  child: Text(
                    'your productivity and wellness',
                    style: GoogleFonts.prompt(
                        fontWeight: FontWeight.w600,
                        color: themeData ? Colors.black54 : Colors.white54),
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
                              fontSize: 17,
                              color: themeData ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: themeData ? Colors.black : Colors.white),
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
                    style: TextButton.styleFrom(
                        primary: themeData ? Colors.black54 : Colors.white54),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SigninScreen()));
                    },
                    child: Text(
                      'Already have an account',
                      style: TextStyle(
                          color: themeData ? Colors.black : Colors.white),
                    )),
              ))
            ],
          ),
        ),
      ),
    );
  }
}