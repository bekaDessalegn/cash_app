import 'package:another_flushbar/flushbar.dart';
import 'package:cash_app/core/constants.dart';
import 'package:flutter/material.dart';

Widget somethingWentWrong({required BuildContext context, required String message, required VoidCallback onPressed}) =>
    Flushbar(
      flushbarStyle: FlushbarStyle.GROUNDED,
      flushbarPosition: FlushbarPosition.TOP,
      message: message,
      mainButton: TextButton(onPressed: (){
        onPressed();
        Navigator.pop(context);
      }, child: Text("Try again")),
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: primaryColor,
      ),
      leftBarIndicatorColor: primaryColor,
    )..show(context);