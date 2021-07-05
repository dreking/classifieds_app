import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isAndroid = Platform.isAndroid;

    return Center(
      child: Container(
        width: 170,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            isAndroid
                ? CircularProgressIndicator()
                : CupertinoActivityIndicator(),
            Text(
              'Loading please wait',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
