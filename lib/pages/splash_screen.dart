import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:kudidemo/navbar/navbar.dart';
import 'package:kudidemo/pages/landing_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedSplashScreen(
      splash: Container(
        height: size.height,
        width: size.width,
        child: Image.asset('assets/images/neontwo.png'),
      ),
      splashIconSize: 450,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: const Color(0xFF181818),
      nextScreen: LandingScreen(),
      pageTransitionType: PageTransitionType.fade,
    );
  }
}
