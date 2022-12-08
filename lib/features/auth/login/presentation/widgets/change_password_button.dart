import 'dart:convert';

import 'package:cash_app/core/constants.dart';
import 'package:cash_app/features/auth/login/presentation/blocs/signin_bloc.dart';
import 'package:cash_app/features/auth/login/presentation/blocs/signin_event.dart';
import 'package:cash_app/features/common_widgets/normal_text.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget changePasswordButton({required BuildContext context, required final recoverPasswordFormKey, required TextEditingController newPasswordController, required TextEditingController confirmPasswordController, required bool isLoading}){
  return ElevatedButton(
    onPressed: isLoading ? null : () {
      if (recoverPasswordFormKey.currentState!.validate()) {
        var newBytes = utf8.encode(newPasswordController.text);
        var newSha512 = sha256.convert(newBytes);
        var hashedNewPassword = newSha512.toString();
        var confirmBytes =
        utf8.encode(confirmPasswordController.text);
        var confirmSha512 = sha256.convert(confirmBytes);
        var hashedConfirmPassword = confirmSha512.toString();
        final resetPassword = BlocProvider.of<SignInBloc>(context);
        final recoveryToken = Uri.base.queryParameters['t'];
        final u = Uri.base.queryParameters['u'];
        print(u);
        if(u.toString() == "admin"){
          resetPassword.add(AdminResetEmailEvent(recoveryToken!, hashedNewPassword));
        } else{
          resetPassword.add(ResetEmailEvent(recoveryToken!, hashedNewPassword));
        }
        print(hashedNewPassword);
        print(recoveryToken);
      }
    },
    style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        backgroundColor: primaryColor,
        disabledBackgroundColor: disabledPrimaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10))),
    child: isLoading
        ? SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        color: onPrimaryColor,
      ),
    )
        : normalText(
        value: "Change Password",
        size: 16,
        color: onPrimaryColor),
  );
}