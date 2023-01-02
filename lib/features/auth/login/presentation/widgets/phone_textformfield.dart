import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/features/common_widgets/bold_text.dart';
import 'package:flutter/material.dart';

Widget phoneOrEmailWidget(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      boldText(value: "Phone or Email", size: defaultFontSize, color: onBackgroundColor),
      const SizedBox(height: smallSpacing,),
      TextFormField(
        controller: phoneOrEmailController,
        validator: (value){
          if(value!.isEmpty){
            return "Value can not be empty";
          }
          else{
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: "Enter your phone or email",
          hintStyle: const TextStyle(color: textInputPlaceholderColor),
          contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: textInputBorderColor),
            borderRadius: BorderRadius.all(
              Radius.circular(defaultRadius),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: dangerColor),
          ),
        ),
      ),
    ],
  );
}