import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditTextField extends StatelessWidget {
  final Widget? prefixIcon;
  final String initialValue;
  final String emptytext;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  const EditTextField(
      {Key? key,
      this.prefixIcon,
      this.keyboardType,
      required this.initialValue,
      required this.emptytext,
      required this.onChanged})
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
          onChanged: onChanged,
          initialValue: initialValue,
          validator: (value) => value!.isEmpty ? emptytext : null,
          keyboardType: keyboardType,
          cursorColor: Colors.black45,
          style: GoogleFonts.prompt(
              color: Theme.of(context).textTheme.bodyText2!.color),
          decoration:
              InputDecoration(prefixIcon: prefixIcon, border: InputBorder.none),
        ));
    ;
  }
}
