import 'dart:convert';

import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:cash_app/features/auth/signup/data/models/signup.dart';
import 'package:cash_app/features/auth/signup/presentation/blocs/signup_bloc.dart';
import 'package:cash_app/features/auth/signup/presentation/blocs/signup_event.dart';
import 'package:cash_app/features/common_widgets/normal_button.dart';
import 'package:cash_app/features/common_widgets/normal_text.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Widget signUpButton(
    {required BuildContext context,
    required String text,
    required bool isLoading}) {
  final _prefs = PrefService();
  return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: isLoading ? null : () async {
            if (signupFormKey.currentState!.validate()) {
              var bytes = utf8.encode(signupPasswordController.text);
              var sha512 = sha256.convert(bytes);
              var hashedPassword = sha512.toString();
              print(hashedPassword);
              final affLink = await _prefs.readAffiliateLink();
              print(affLink);
              String phone = "+${signupPhoneController.value!.countryCode}${signupPhoneController.value!.nsn}";
              print(phone);
              final signup = BlocProvider.of<SignUpBloc>(context);
              if(affLink.toString() != "null"){
                print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
                print(affLink);
                signup.add(PostSignUpEvent(SignUp(
                    fullName: signupFullNameController.text,
                    phone: phone,
                    email: signupEmailController.text,
                    passwordHash: hashedPassword,
                    parentId: affLink.toString()
                )));
              } else{
                print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
                signup.add(PostSignUpEvent(SignUp(
                    fullName: signupFullNameController.text,
                    phone: phone,
                    email: signupEmailController.text,
                    passwordHash: hashedPassword
                )));
              }
            }
          },
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: disabledPrimaryColor,
            backgroundColor: primaryColor,
            foregroundColor: onPrimaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(defaultRadius)),
            padding: const EdgeInsets.symmetric(vertical: buttonHeight),
          ),
          child: isLoading
              ? SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    color: onPrimaryColor,
                  ),
                )
              : normalText(
                  value: text, size: defaultFontSize, color: onPrimaryColor)));
}
