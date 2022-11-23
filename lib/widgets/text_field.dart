import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String emptytext;
  final String hintText;
  final String? initialValue;

  const CustomTextField(
      {Key? key,
      this.initialValue,
      required this.controller,
      required this.emptytext,
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
          initialValue: initialValue,
          controller: controller,
          validator: (value) => value!.isEmpty ? emptytext : null,
          keyboardType: TextInputType.text,
          cursorColor: Theme.of(context).textTheme.bodyText2!.color,
          style: GoogleFonts.prompt(
              color: Theme.of(context).textTheme.bodyText2!.color),
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.prompt(),
              border: InputBorder.none),
        ));
  }
}
