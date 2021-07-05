import 'package:flutter/material.dart';

class CustomDismissKeyboard extends StatelessWidget {
  final Widget child;

  const CustomDismissKeyboard({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      onPanDown: (_) => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
