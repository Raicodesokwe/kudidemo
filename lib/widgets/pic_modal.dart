import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
    return Container();
  }
}
