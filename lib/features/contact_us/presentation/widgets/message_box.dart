import 'package:cash_app/core/constants.dart';
import 'package:cash_app/features/common_widgets/bold_text.dart';
import 'package:cash_app/features/common_widgets/semi_bold_text.dart';
import 'package:flutter/material.dart';

Widget messageTextFormField({required Widget type, required String hint, required TextEditingController controller}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      type,
      const SizedBox(height: smallSpacing,),
      TextFormField(
        controller: controller,
        maxLines: 7,
        minLines: 6,
        autocorrect: true,
        keyboardType: TextInputType.multiline,
        onChanged: (String str){
          // print(controller.text);
        },
        validator: (value) {
          if(value!.isEmpty){
            return "Value can not be empty";
          } else{
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: textInputPlaceholderColor),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: textInputBorderColor),
            borderRadius: BorderRadius.all(
              Radius.circular(defaultRadius),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: dangerColor),
          ),
        ),
      ),
    ],
  );
}