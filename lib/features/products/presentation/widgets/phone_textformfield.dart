import 'package:cash_app/core/constants.dart';
import 'package:cash_app/features/common_widgets/bold_text.dart';
import 'package:cash_app/features/common_widgets/semi_bold_text.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

Widget phoneTextFormField({required String type, required String hint, required PhoneController controller}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      boldText(value: type, size: defaultFontSize, color: onBackgroundColor),
      const SizedBox(height: smallSpacing,),
      PhoneFormField(
        controller: controller,
        defaultCountry: IsoCode.ET,
        autovalidateMode: AutovalidateMode.disabled,
        decoration: InputDecoration(
          hintText: "Enter your phone number",
          contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    ],
  );
}