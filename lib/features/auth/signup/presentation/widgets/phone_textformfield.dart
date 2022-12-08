import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/features/common_widgets/bold_text.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

class SignUpPhoneTextFormField extends StatelessWidget {

  bool enabled;
  SignUpPhoneTextFormField(this.enabled);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boldText(value: "Phone", size: defaultFontSize, color: onBackgroundColor),
        const SizedBox(height: smallSpacing,),
        PhoneFormField(
          controller: signupPhoneController,
          defaultCountry: IsoCode.ET,
          enabled: enabled,
          validator: PhoneValidator.compose([
            // list of validators to use
            PhoneValidator.required(errorText: "Value can not be empty"),
            PhoneValidator.valid(),
            // ..
          ]),
          autovalidateMode: AutovalidateMode.disabled,
          decoration: InputDecoration(
            filled: true,
            fillColor: enabled ? backgroundColor : disabledColor,
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
}