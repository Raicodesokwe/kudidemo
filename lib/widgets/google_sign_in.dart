import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../navbar/navbar.dart';
import '../pages/name_pic.dart';

class GoogleWidget extends StatelessWidget {
  final String sign;
  const GoogleWidget({Key? key, required this.sign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      width: size.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 30, child: Image.asset('assets/images/GoogleLogo.png')),
          SizedBox(
            width: 20,
          ),
          Text(
            'Sign $sign with Google',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), color: Colors.black),
    );
  }
}
