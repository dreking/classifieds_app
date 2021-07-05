import 'package:flutter/material.dart';

class CustomInputCard extends StatelessWidget {
  final Widget child;
  final Color? color;

  CustomInputCard({
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: color ?? null,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: child,
      ),
    );
  }
}
