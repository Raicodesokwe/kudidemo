import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kudidemo/models/pic_model.dart';
import 'package:kudidemo/providers/pic_provider.dart';
import 'package:provider/provider.dart';

class PicModal extends StatefulWidget {
  final void Function(File _pickedImg) imagePickFunktion;

  const PicModal({Key? key, required this.imagePickFunktion}) : super(key: key);

  @override
  State<PicModal> createState() => _PicModalState();
}

class _PicModalState extends State<PicModal> {
  File? _pickedImg;

  void _openGallery(BuildContext context) async {
    final picture = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 80, maxWidth: 150);
    final pickedImageFile = File(picture!.path);
    setState(() {
      _pickedImg = pickedImageFile;
    });
    widget.imagePickFunktion(pickedImageFile);

    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    final picture = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 80, maxWidth: 150);
    final pickedImageFile = File(picture!.path);
    setState(() {
      _pickedImg = pickedImageFile;
    });
    widget.imagePickFunktion(pickedImageFile);
    Navigator.of(context).pop();
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
    Color greenColor = const Color(0xFF00AF19);
    Future<void> _showSelectionDialog(BuildContext context) {
      Color greenColor = const Color(0xFF00AF19);
      Size size = MediaQuery.of(context).size;
      return Platform.isIOS
          ? showCupertinoDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: CupertinoAlertDialog(
                    title: Text(
                      'PICK IMAGE FROM :',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.prompt(fontWeight: FontWeight.w700),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 50,
                          decoration: decorator.copyWith(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Theme.of(context).backgroundColor),
                          child: Center(
                            child: GestureDetector(
                              child: Text(
                                "Gallery",
                                style: GoogleFonts.prompt(
                                    fontWeight: FontWeight.w600),
                              ),
                              onTap: () {
                                _openGallery(context);
                              },
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        Container(
                          height: 50,
                          decoration: decorator.copyWith(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Theme.of(context).backgroundColor),
                          child: Center(
                            child: GestureDetector(
                              child: Text(
                                "Camera",
                                style: GoogleFonts.prompt(
                                    fontWeight: FontWeight.w600),
                              ),
                              onTap: () {
                                _openCamera(context);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })
          : showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Theme.of(context).backgroundColor,
                  // title: const Text(
                  //   'PICK IMAGE FROM :',
                  //   textAlign: TextAlign.center,
                  // ),
                  content: Consumer<PicProvider>(
                      builder: (context, notifier, child) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: size.height * 0.3,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                              color: notifier.color,
                              borderRadius: BorderRadius.circular(12)),
                          child:
                              SvgPicture.asset('assets/images/${notifier.pic}'),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            children: List.generate(
                                picList.length,
                                (index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: GestureDetector(
                                        onTap: () {
                                          notifier.changePic(index);
                                        },
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          child: SvgPicture.asset(
                                              'assets/images/${picList[index].pic}'),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: picList[index].color,
                                            border: Border.all(
                                                width: picList[index].pic ==
                                                        notifier.pic
                                                    ? 3
                                                    : 1,
                                                color: picList[index].pic ==
                                                        notifier.pic
                                                    ? const Color(0xFF240754)
                                                    : Colors.black),
                                          ),
                                        ),
                                      ),
                                    )),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
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
                    );
                  }),
                );
              });
    }

    return Consumer<PicProvider>(builder: (context, notifier, child) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: decorator.copyWith(
                shape: BoxShape.circle,
                color: Theme.of(context).backgroundColor),
            child: Container(
              height: 80,
              width: 80,
              child: _pickedImg == null
                  ? Center(
                      child: SvgPicture.asset(
                      'assets/images/${notifier.pic}',
                      height: 50,
                    ))
                  : Container(),
              decoration: _pickedImg == null
                  ? BoxDecoration(
                      color: notifier.color,
                      border: Border.all(color: Colors.black54, width: 4),
                      shape: BoxShape.circle,
                    )
                  : BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 4),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover, image: FileImage(_pickedImg!))),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              _showSelectionDialog(context);
            },
            //pointer to function

            label: Text(
              'Add Avatar',
              style: GoogleFonts.prompt(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
            icon: Icon(FontAwesomeIcons.cameraRetro),
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(7),
                backgroundColor: MaterialStateProperty.all(Colors.black)),
          ),
        ],
      );
    });
  }
}
