import 'package:cash_app/core/constants.dart';
import 'package:cash_app/features/common_widgets/logo_image.dart';
import 'package:flutter/material.dart';

Widget normalHeader({required String heroShortTitle, required String heroLongTitle}) {
  return SafeArea(
    child: Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(height: 30,),
          PlatformLogoImage(logoBorderRadius: 0, logoWidth: 200, logoHeight: 80),
          Center(
            child: Text(
              heroLongTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: onBackgroundColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}