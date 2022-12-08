import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/features/common_widgets/bold_text.dart';
import 'package:flutter/material.dart';

class SignUpEmailTextFormField extends StatelessWidget {

  bool enabled;
  SignUpEmailTextFormField(this.enabled);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boldText(value: "Email", size: defaultFontSize, color: onBackgroundColor),
        const SizedBox(height: smallSpacing,),
        TextFormField(
          controller: signupEmailController,
          enabled: enabled,
          validator: (value) {
            if (value!.isEmpty) {
              return "Value can not be empty";
            } else if (RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value)) {
              return null;
            } else {
              return "Please enter valid email";
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: enabled ? backgroundColor : disabledColor,
            hintText: "Enter your email",
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
}