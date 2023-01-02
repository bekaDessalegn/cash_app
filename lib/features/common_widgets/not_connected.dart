import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Widget internetNotAvailable({required BuildContext context}) {
  return Flushbar(
    flushbarStyle: FlushbarStyle.GROUNDED,
    flushbarPosition: FlushbarPosition.TOP,
    message: 'No Internet Connection!',
    leftBarIndicatorColor: Colors.orange,
  );
}

