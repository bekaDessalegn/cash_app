import 'package:another_flushbar/flushbar.dart';
import 'package:cash_app/core/constants.dart';
import 'package:flutter/material.dart';

Widget buildYoutubeErrorLayout({required BuildContext context, required String message}) =>
    Flushbar(
      flushbarStyle: FlushbarStyle.GROUNDED,
      flushbarPosition: FlushbarPosition.TOP,
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: primaryColor,
      ),
      leftBarIndicatorColor: primaryColor,
    );