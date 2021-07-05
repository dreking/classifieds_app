import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String text;

  CustomButton({
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      padding: EdgeInsets.all(20),
      fillColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: Colors.white),
      ),
      onPressed: onTap as void Function()?,
    );
  }
}
