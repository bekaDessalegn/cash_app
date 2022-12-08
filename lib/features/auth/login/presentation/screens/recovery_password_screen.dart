import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/features/auth/login/presentation/blocs/signin_bloc.dart';
import 'package:cash_app/features/auth/login/presentation/blocs/signin_state.dart';
import 'package:cash_app/features/auth/login/presentation/widgets/change_password_button.dart';
import 'package:cash_app/features/common_widgets/error_flashbar.dart';
import 'package:cash_app/features/common_widgets/main_logo.dart';
import 'package:cash_app/features/common_widgets/normal_text.dart';
import 'package:cash_app/features/common_widgets/semi_bold_text.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';

class MobileRecoveryPasswordScreen extends StatefulWidget {
  @override
  State<MobileRecoveryPasswordScreen> createState() =>
      _MobileRecoveryPasswordScreenState();
}

class _MobileRecoveryPasswordScreenState
    extends State<MobileRecoveryPasswordScreen> {
  bool newSecureText = true;
  bool confirmSecureText = true;

  final recoverPasswordFormKey = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: BlocConsumer<SignInBloc, SignInState>(listener: (_, state) {
              if (state is ResetEmailFailed) {
                buildErrorLayout( context: context,
                    message: state.errorType);
              }
            }, builder: (_, state) {
              if (state is ResetEmailLoading) {
                return buildInitialInput(isLoading: true);
              } else if (state is ResetEmailSuccessful) {
                return buildSuccessfulInput();
              } else {
                return buildInitialInput(isLoading: false);
              }
            }),
          ),
        ),
      ),
    );
  }

  Widget buildInitialInput({required bool isLoading}) => Form(
    key: recoverPasswordFormKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 80,
        ),
        Center(
            child: mainLogo()),
        SizedBox(
          height: 50,
        ),
        Center(
            child: Text(
              "Enter New Password",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                  color: onBackgroundColor),
            )),
        SizedBox(
          height: 10,
        ),
        Text(
          "Looks like you are trying to reset the password for the account. Please enter your new password twice. So we can verify you typed it correctly.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: onBackgroundColor),
        ),
        SizedBox(
          height: 20,
        ),
        semiBoldText(
            value: "New Password",
            size: defaultFontSize,
            color: onBackgroundColor),
        const SizedBox(
          height: smallSpacing,
        ),
        TextFormField(
          controller: newPasswordController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Value can not be empty";
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
              hintText: "",
              hintStyle: TextStyle(color: textInputPlaceholderColor),
              contentPadding:
              EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
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
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    newSecureText = !newSecureText;
                  });
                },
                icon: Icon(
                  newSecureText == true
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: onBackgroundColor,
                ),
              )),
          obscureText: newSecureText,
        ),
        SizedBox(
          height: 10,
        ),
        semiBoldText(
            value: "Confirm Password",
            size: defaultFontSize,
            color: onBackgroundColor),
        const SizedBox(
          height: smallSpacing,
        ),
        TextFormField(
          controller: confirmPasswordController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Value can not be empty";
            } else if (value != newPasswordController.text) {
              return "Both passwords must be the same";
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
              hintText: "",
              hintStyle: TextStyle(color: textInputPlaceholderColor),
              contentPadding:
              EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
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
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    confirmSecureText = !confirmSecureText;
                  });
                },
                icon: Icon(
                  confirmSecureText == true
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: onBackgroundColor,
                ),
              )),
          obscureText: confirmSecureText,
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: double.infinity,
          child: changePasswordButton(
              context: context,
              recoverPasswordFormKey: recoverPasswordFormKey,
              newPasswordController: newPasswordController,
              confirmPasswordController: confirmPasswordController,
              isLoading: isLoading),
        ),
      ],
    ),
  );

  Widget buildSuccessfulInput() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 80,
      ),
      Center(
          child: mainLogo()),
      SizedBox(
        height: 80,
      ),
      Center(
          child: Iconify(
            Ic.baseline_task_alt,
            color: primaryColor,
            size: 50,
          )),
      SizedBox(
        height: 10,
      ),
      Center(
          child: Text(
            "Password Reset Successful",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 21,
                color: onBackgroundColor),
          )),
      SizedBox(
        height: 10,
      ),
      Text(
        "Awesome. You have successfully reset the password for your account.",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, color: onBackgroundColor),
      ),
      SizedBox(
        height: 20,
      ),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            context.go(APP_PAGE.login.toPath);
          },
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child:
          normalText(value: "Log in", size: 16, color: onPrimaryColor),
        ),
      ),
    ],
  );
}
