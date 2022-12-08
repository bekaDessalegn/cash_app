import 'package:cash_app/core/constants.dart';
import 'package:cash_app/features/common_widgets/normal_text.dart';
import 'package:flutter/material.dart';

Widget normalButton({required String text, required VoidCallback onTap}){
  return ElevatedButton(onPressed: (){
    onTap();
  },
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: onPrimaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadius)
        ),
        padding: const EdgeInsets.symmetric(vertical: buttonHeight),
      ),
      child: normalText(value: text, size: defaultFontSize, color: onPrimaryColor));
}