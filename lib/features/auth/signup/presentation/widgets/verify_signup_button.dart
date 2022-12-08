import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/services/auth_service.dart';
import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:cash_app/features/auth/signup/presentation/blocs/signup_bloc.dart';
import 'package:cash_app/features/auth/signup/presentation/blocs/signup_event.dart';
import 'package:cash_app/features/common_widgets/normal_button.dart';
import 'package:cash_app/features/common_widgets/normal_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final _prefs = PrefService();

Widget verifySignUpButton({required BuildContext context, required String text, required bool isLoading}) {
  final authService = Provider.of<AuthService>(context);
  return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: isLoading ? null : () {
            if (verifyFormKey.currentState!.validate()) {
              // _prefs.createJoiningBonus(0);
              isWelcome = true;
              authService.login();
              final verifyEmail = BlocProvider.of<SignUpBloc>(context);
              verifyEmail.add(VerifySignUpEvent(verifySignUpController.text));
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
          child: isLoading ? SizedBox(height: 16, width: 16, child: CircularProgressIndicator(color: onPrimaryColor,),) : normalText(
              value: text, size: defaultFontSize, color: onPrimaryColor)));
}
