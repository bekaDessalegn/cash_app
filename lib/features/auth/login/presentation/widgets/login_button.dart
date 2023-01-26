import 'dart:convert';

import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/features/auth/login/data/models/signin.dart';
import 'package:cash_app/features/auth/login/presentation/blocs/signin_bloc.dart';
import 'package:cash_app/features/auth/login/presentation/blocs/signin_event.dart';
import 'package:cash_app/features/common_widgets/normal_text.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget loginButton(
    {required BuildContext context,
    required String text,
    required bool isLoading, required GlobalKey<FormState> globalKey
    }) {
  return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: isLoading ? null : () {
            if (globalKey.currentState!.validate()) {
              var bytes = utf8.encode(password.text);
              var sha512 = sha256.convert(bytes);
              var hashedPassword = sha512.toString();
              print(hashedPassword);
              final signIn = BlocProvider.of<SignInBloc>(context);
              signIn.add(PostSignInEvent(SignIn(phoneOrEmail: phoneOrEmailController.text, passwordHash: hashedPassword)));
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
