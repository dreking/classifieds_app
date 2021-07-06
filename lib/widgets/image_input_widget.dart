import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:classifieds_app/components/custom_dialog.dart';

class ImageInputWidget extends StatefulWidget {
  final Function onSelectImage;
  final String buttonText;

  ImageInputWidget({
    Key? key,
    required this.onSelectImage,
    required this.buttonText,
  }) : super(key: key);

  @override
  _ImageInputWidgetState createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends State<ImageInputWidget> {
  final _picker = ImagePicker();

  File? _imageFile;

  Future<void> _takePicture() async {
    final permission = await Permission.storage.request();

    if (!permission.isGranted) {
      await Permission.storage.request();
      return await showDialog(
        context: context,
        builder: (context) => CustomDialog(
          title: 'Camera Permission',
          text: 'We need camera permission to upload image',
          onTap: () => Navigator.of(context).pop(),
          status: false,
        ),
      );
    }

    final _pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (_pickedFile == null) return;

    setState(() {
      _imageFile = File(_pickedFile.path);
    });

    widget.onSelectImage(_imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FittedBox(
          child: TextButton.icon(
            icon: Icon(Icons.camera),
            label: Text(widget.buttonText),
            onPressed: _takePicture,
          ),
        ),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: _imageFile != null
              ? Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
        ),
      ],
    );
  }
}
