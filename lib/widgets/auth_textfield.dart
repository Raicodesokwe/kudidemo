import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  const AuthTextField(
      {Key? key,
      required this.controller,
      required this.validator,
      required this.onChanged,
      required this.keyboardType,
      required this.hintText})
      : super(key: key);

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
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width * 0.8,
        decoration: decorator.copyWith(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(10.0)),
        child: TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          onChanged: onChanged,
          cursorColor: Colors.black45,
          style: GoogleFonts.prompt(color: Colors.black),
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.prompt(),
              border: InputBorder.none),
        ));
  }
}
