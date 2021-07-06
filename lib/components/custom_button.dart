import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String text;
  final IconData icon;

  CustomButton({
    required this.onTap,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap as void Function()?,
      icon: Icon(icon),
      label: Text(
        text.toUpperCase(),
        style: TextStyle(color: Colors.white),
      ),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(15),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.all(15),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).primaryColor,
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
