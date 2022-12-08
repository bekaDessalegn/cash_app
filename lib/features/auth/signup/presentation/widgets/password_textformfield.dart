import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/features/common_widgets/bold_text.dart';
import 'package:flutter/material.dart';

class SignUpPasswordTextFormField extends StatefulWidget {

  bool enabled;
  SignUpPasswordTextFormField(this.enabled);

  @override
  State<SignUpPasswordTextFormField> createState() => _SignUpPasswordTextFormFieldState();
}

class _SignUpPasswordTextFormFieldState extends State<SignUpPasswordTextFormField> {
  bool _secureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boldText(value: "Password", size: defaultFontSize, color: onBackgroundColor),
        const SizedBox(
          height: smallSpacing,
        ),
        TextFormField(
          controller: signupPasswordController,
          validator: (value){
            if(value!.isEmpty){
              return "Value can not be empty";
            } else if (value.length < 6) {
              return "Password should be at least 6 characters";
            }
            else{
              return null;
            }
          },
          enabled: widget.enabled,
          decoration: InputDecoration(
              filled: true,
              fillColor: widget.enabled ? backgroundColor : disabledColor,
              hintText: "Enter your password",
              hintStyle: const TextStyle(color: textInputPlaceholderColor),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
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
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _secureText = !_secureText;
                  });
                },
                icon: Icon(
                  _secureText == true ? Icons.visibility : Icons.visibility_off,
                  color: onBackgroundColor,
                ),
              )),
          obscureText: _secureText,
        ),
      ],
    );
  }
}
