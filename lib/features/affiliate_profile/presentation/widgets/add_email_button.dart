import 'package:cash_app/core/constants.dart';
import 'package:cash_app/features/affiliate_profile/presentation/blocs/affiliates_bloc.dart';
import 'package:cash_app/features/affiliate_profile/presentation/blocs/affiliates_event.dart';
import 'package:cash_app/features/common_widgets/normal_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget addEmailButton({required BuildContext context, required TextEditingController emailController, required final verifyEmailKey, required bool isLoading}){
  return ElevatedButton(
    onPressed: isLoading ? null : () {
      if (verifyEmailKey.currentState!.validate()) {
        final putEmail = BlocProvider.of<PutEmailBloc>(context);
        putEmail.add(PutEmailEvent(emailController.text));
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
        value: "Save", size: 20, color: onPrimaryColor),
  );
}