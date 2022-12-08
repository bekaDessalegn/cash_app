import 'package:another_flushbar/flushbar.dart';
import 'package:cash_app/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';

Widget buildSuccessLayout({required BuildContext context, required String message}) =>
    Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      message: message,
      duration:  Duration(seconds: 2),
      icon: Iconify(
        Ic.outline_done,
        size: 28.0,
        color: Colors.greenAccent,
      ),
      leftBarIndicatorColor: Colors.greenAccent,
    )..show(context);