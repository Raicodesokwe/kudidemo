import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool hidepassword;
  final String hintText;
  final String? Function(String?)? validate;
  final TextInputType textInputType;
  const AuthTextField(
      {Key? key,
      required this.controller,
      required this.hidepassword,
      required this.textInputType,
      required this.validate,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width * 0.8,
        decoration: decorator.copyWith(
            color: themeData ? Colors.grey[300] : Colors.grey[900],
            borderRadius: BorderRadius.circular(10.0)),
        child: TextFormField(
          controller: controller,
          validator: validate,
          keyboardType: textInputType,
          obscureText: hidepassword,
          onChanged: (value) {
            controller.text = value;
          },
          cursorColor: Colors.black45,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.prompt(),
              border: InputBorder.none),
        ));
  }
}
