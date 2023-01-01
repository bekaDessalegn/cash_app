import 'package:cash_app/core/constants.dart';
import 'package:cash_app/features/common_widgets/share_platform_dialog.dart';
import 'package:flutter/material.dart';

Widget shareButton({required BuildContext context}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          backgroundColor: primaryColor),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context){
              return sharePlatformDialog(context: context);
            });
      },
      child: Text(
        "Share",
        style: TextStyle(color: onPrimaryColor, fontSize: 16),
      ));
}
