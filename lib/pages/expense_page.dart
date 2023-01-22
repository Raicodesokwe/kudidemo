import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kudidemo/models/expense_item.dart';
import 'package:kudidemo/pages/finances_page.dart';
import 'package:kudidemo/providers/expense_provider.dart';
import 'package:kudidemo/utils/utils.dart';
import 'package:kudidemo/widgets/expense_notes.dart';
import 'package:kudidemo/widgets/icon_circle.dart';
import 'package:kudidemo/widgets/keypad_circle.dart';
import 'package:provider/provider.dart';

class ExpensePage extends StatefulWidget {
  final String expenseName;
  final String expenseImage;
  final Color tileColor;
  const ExpensePage(
      {Key? key,
      required this.expenseName,
      required this.tileColor,
      required this.expenseImage})
      : super(key: key);

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final TextEditingController controller = TextEditingController();
  File? imgFile;
  String? url;
  void imagePickFunktion(File img) {
    imgFile = img;
  }

  File? _pickedImg;
  void _openGallery(BuildContext context) async {
    final picture = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    final pickedImageFile = File(picture!.path);
    setState(() {
      _pickedImg = pickedImageFile;
    });
    imagePickFunktion(pickedImageFile);
    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    final picture = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    final pickedImageFile = File(picture!.path);
    setState(() {
      _pickedImg = pickedImageFile;
    });
    imagePickFunktion(pickedImageFile);
    Navigator.of(context).pop();
  }

  DateTime selectedDate = DateTime.now();
  _selectDay() async {
    final date = await showDatePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(fontFamily: 'grifterbold'),
          child: child!,
        );
      },
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2088),
    );
    if (date == null) return null;

    setState(() => selectedDate = date);
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final expense = ExpenseItem(
        currency: expenseProvider.currency,
        amount:
            controller.text.isNotEmpty ? double.parse(controller.text) : 0.0,
        category: widget.expenseName,
        date: selectedDate,
        notes: expenseProvider.expenseNotes);

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
          body: Column(
        children: [
          _pickedImg == null
              ? Container(
                  height: size.height * 0.3,
                  width: double.infinity,
                  color: widget.tileColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.expenseName,
                        style: TextStyle(fontSize: 25),
                      ),
                      Image.asset(widget.expenseImage),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          height: 70,
                          child: Center(
                              child: TextField(
                            style: TextStyle(
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .fontFamily,
                                fontSize: 40,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .color),
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            controller: controller,
                            textAlign: TextAlign.center,
                            showCursor: false,

                            // Disable the default soft keybaord
                            keyboardType: TextInputType.none,
                          )),
                        ),
                      ),
                    ],
                  ),
                )
              : Stack(
                  children: [
                    Container(
                      height: size.height * 0.3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(_pickedImg!))),
                    ),
                    Positioned(
                      top: size.height * 0.05,
                      right: size.width * 0.01,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.expenseName,
                            style: TextStyle(fontSize: 25),
                          ),
                          Image.asset(widget.expenseImage),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Theme.of(context).backgroundColor),
                              height: 70,
                              width: size.width * 0.9,
                              child: Center(
                                  child: TextField(
                                onChanged: (value) {},
                                style: TextStyle(
                                    fontFamily: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .fontFamily,
                                    fontSize: 40,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .color),

                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                controller: controller,
                                textAlign: TextAlign.center,
                                showCursor: false,

                                // Disable the default soft keybaord
                                keyboardType: TextInputType.none,
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _selectDay();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(Utils.toDate(selectedDate)),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                    decoration: decorator.copyWith(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).backgroundColor),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return ExpenseNotes();
                        });
                  },
                  child: Container(
                    decoration: decorator.copyWith(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).backgroundColor),
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [Text('Add notes'), Icon(Icons.note_add_sharp)],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Theme.of(context).backgroundColor,
                        title: Text(
                          'PICK IMAGE FROM :',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color,
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .fontFamily),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _openGallery(context);
                              },
                              child: Container(
                                height: 50,
                                decoration: decorator.copyWith(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Theme.of(context).backgroundColor),
                                child: Center(
                                  child: Text(
                                    "Gallery",
                                    style: GoogleFonts.prompt(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(8.0)),
                            GestureDetector(
                              onTap: () {
                                _openCamera(context);
                              },
                              child: Container(
                                height: 50,
                                decoration: decorator.copyWith(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Theme.of(context).backgroundColor),
                                child: Center(
                                  child: Text(
                                    "Camera",
                                    style: GoogleFonts.prompt(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                decoration: decorator.copyWith(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).backgroundColor),
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text('Add receipt'), Icon(Icons.photo)],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                KeypadCircle(
                  number: 1,
                  controller: controller,
                ),
                KeypadCircle(
                  number: 2,
                  controller: controller,
                ),
                KeypadCircle(
                  number: 3,
                  controller: controller,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                KeypadCircle(
                  number: 4,
                  controller: controller,
                ),
                KeypadCircle(
                  number: 5,
                  controller: controller,
                ),
                KeypadCircle(
                  number: 6,
                  controller: controller,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                KeypadCircle(
                  number: 7,
                  controller: controller,
                ),
                KeypadCircle(
                  number: 8,
                  controller: controller,
                ),
                KeypadCircle(
                  number: 9,
                  controller: controller,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      controller.text = controller.text.substring(
                          0,
                          controller.text.isNotEmpty
                              ? controller.text.length - 1
                              : 0);
                    },
                    child: IconCircle(icon: Icons.close)),
                KeypadCircle(
                  number: 0,
                  controller: controller,
                ),
                GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor:
                                  Theme.of(context).backgroundColor,
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Center(
                                    child: Text(
                                        'Are you sure you want to save this expense?',
                                        style: TextStyle(
                                            fontSize: 20,
                                            // fontWeight: FontWeight.w300,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .color,
                                            fontFamily: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .fontFamily)),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              height: 70,
                                              width: 70,
                                              child: Center(
                                                child: Icon(Icons.close),
                                              ),
                                              decoration: decorator.copyWith(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.red
                                                            .withAlpha(225),
                                                        blurRadius: 45,
                                                        spreadRadius: 15,
                                                        offset: Offset(0, 0))
                                                  ],
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.red,
                                                        Colors.redAccent
                                                      ],
                                                      begin:
                                                          Alignment.centerRight,
                                                      end:
                                                          Alignment.centerLeft),
                                                  shape: BoxShape.circle,
                                                  color: Theme.of(context)
                                                      .backgroundColor),
                                            )),
                                        GestureDetector(
                                            onTap: () {
                                              expenseProvider
                                                  .addExpense(expense);
                                              print(
                                                  'das amount dey ${expenseProvider.expenseNotes}');
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (c) =>
                                                              FinancesPage()),
                                                      (route) => false);
                                            },
                                            child: Container(
                                              height: 70,
                                              width: 70,
                                              child: Center(
                                                child: Icon(Icons.check),
                                              ),
                                              decoration: decorator.copyWith(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.green
                                                            .withAlpha(225),
                                                        blurRadius: 45,
                                                        spreadRadius: 15,
                                                        offset: Offset(0, 0))
                                                  ],
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.green,
                                                        Colors.greenAccent
                                                      ],
                                                      begin:
                                                          Alignment.centerRight,
                                                      end:
                                                          Alignment.centerLeft),
                                                  shape: BoxShape.circle,
                                                  color: Theme.of(context)
                                                      .backgroundColor),
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    child: Container(
                      height: 70,
                      width: 70,
                      child: Center(
                        child: Icon(Icons.check),
                      ),
                      decoration: decorator.copyWith(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.green.withAlpha(225),
                                blurRadius: 45,
                                spreadRadius: 15,
                                offset: Offset(0, 0))
                          ],
                          gradient: LinearGradient(
                              colors: [Colors.green, Colors.greenAccent],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft),
                          shape: BoxShape.circle,
                          color: Theme.of(context).backgroundColor),
                    ))
              ],
            ),
          ),
        ],
      )),
    );
  }
}
