import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/widgets/privacy_dialog.dart';
import 'package:kudidemo/widgets/terms_dialog.dart';

class TermsPrivacyPolicy extends StatelessWidget {
  TermsPrivacyPolicy({Key? key}) : super(key: key);
  Future termsDialog(BuildContext context) {
    return Platform.isIOS
        ? showCupertinoDialog(context: context, builder: (_) => TermsDialog())
        : showDialog(context: context, builder: (_) => TermsDialog());
  }

  Future privacyDialog(BuildContext context) {
    return Platform.isIOS
        ? showCupertinoDialog(context: context, builder: (_) => PrivacyDialog())
        : showDialog(context: context, builder: (_) => PrivacyDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
            width: double.infinity,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'By continuing, you are agreeing to our',
                    style: GoogleFonts.prompt(
                        color: Theme.of(context).textTheme.bodyText2!.color),
                  ),
                  TextSpan(
                      text: ' Terms of Service ',
                      style: GoogleFonts.prompt(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFF773D)),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          termsDialog(context);
                        }),
                  TextSpan(
                    text: 'and ',
                    style: GoogleFonts.prompt(
                        color: Theme.of(context).textTheme.bodyText2!.color),
                  ),
                  TextSpan(
                      text: 'Privacy Policy',
                      style: GoogleFonts.prompt(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFF773D)),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          privacyDialog(context);
                        }),
                  TextSpan(
                    text: '.',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
