import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/core/services/auth_service.dart';
import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:cash_app/features/auth/signup/presentation/blocs/signup_bloc.dart';
import 'package:cash_app/features/auth/signup/presentation/blocs/signup_state.dart';
import 'package:cash_app/features/auth/signup/presentation/widgets/email_textformfield.dart';
import 'package:cash_app/features/auth/signup/presentation/widgets/fullname_textformfield.dart';
import 'package:cash_app/features/auth/signup/presentation/widgets/password_textformfield.dart';
import 'package:cash_app/features/auth/signup/presentation/widgets/phone_textformfield.dart';
import 'package:cash_app/features/auth/signup/presentation/widgets/signup_button.dart';
import 'package:cash_app/features/auth/signup/presentation/widgets/verify_signup_button.dart';
import 'package:cash_app/features/auth/signup/presentation/widgets/verify_signup_textformfield.dart';
import 'package:cash_app/features/common_widgets/error_flashbar.dart';
import 'package:cash_app/features/common_widgets/language_picker_widget.dart';
import 'package:cash_app/features/common_widgets/bold_text.dart';
import 'package:cash_app/features/common_widgets/main_logo.dart';
import 'package:cash_app/features/common_widgets/normal_button.dart';
import 'package:cash_app/features/common_widgets/normal_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MobileSignUpBody extends StatelessWidget {

  final _prefs = PrefService();
  final signupFormKey = GlobalKey<FormState>();
  final verifyFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return BlocConsumer<SignUpBloc, SignUpState>(
        builder: (_, state){
          if (state is SignUpStateLoading) {
            return buildInitialInput(context: context, isLoading: true);
          } else if (state is SignUpStateSuccessful) {
            return buildVerifyInput(context: context, isLoading: false);
          } else if (state is VerifySignUpStateLoading) {
            return buildVerifyInput(context: context, isLoading: true);
          }
          else if(state is VerifySignUpStateFailed){
            return buildVerifyInput(context: context, isLoading: false);
          }
          else {
            return buildInitialInput(context: context, isLoading: false);
          }
        },
        listener: (_, state){
          if (state is SignUpStateFailed) {
            buildErrorLayout(
                context: context,
                message: state.errorType);
          } else if (state is VerifySignUpStateFailed) {
            buildErrorLayout(
                context: context,
                message: state.errorType);
          } else if (state is VerifySignUpStateSuccessful) {
            _prefs.createCache(password.text).whenComplete(() {
              authService.login();
              context.go(APP_PAGE.affiliateProducts.toPath);
            });
          }
        });
  }

  Widget buildInitialInput({required BuildContext context, required bool isLoading}) {
    return Form(
      key: signupFormKey,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40,),
              Center(child: mainLogo()
              ),
              SizedBox(
                height: 40,
              ),
              Text("Sign Up", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: onBackgroundColor),),
              SizedBox(
                height: 10,
              ),
              normalText(value: "We are happy to see you around", size: defaultFontSize, color: onBackgroundColor),
              const SizedBox(
                height: mediumSpacing,
              ),
              SignUpFullNameTextFormField(true),
              const SizedBox(
                height: defaultSpacing,
              ),
              SignUpPhoneTextFormField(true),
              const SizedBox(
                height: defaultSpacing,
              ),
              SignUpEmailTextFormField(true),
              const SizedBox(
                height: defaultSpacing,
              ),
              SignUpPasswordTextFormField(true),
              SizedBox(
                height: 30,
              ),
              signUpButton(context: context, text: "Sign up", isLoading: isLoading, signupFormKey: signupFormKey),
              const SizedBox(
                height: smallSpacing,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?", style: TextStyle(fontSize: defaultFontSize, color: onBackgroundColor, fontWeight: FontWeight.w500),),
                  TextButton(
                      onPressed: () {
                        context.push('/login');
                      },
                      child: normalText(value: "Sign In", size: defaultFontSize, color: primaryColor)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildVerifyInput({required BuildContext context, required bool isLoading}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40,),
            Center(child: mainLogo()
            ),
            SizedBox(
              height: 40,
            ),
            Text("Sign Up", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: onBackgroundColor),),
            SizedBox(
              height: 10,
            ),
            normalText(value: "We are happy to see you around", size: defaultFontSize, color: onBackgroundColor),
            const SizedBox(
              height: mediumSpacing,
            ),
            SignUpFullNameTextFormField(false),
            const SizedBox(
              height: defaultSpacing,
            ),
            SignUpPhoneTextFormField(false),
            const SizedBox(
              height: defaultSpacing,
            ),
            SignUpEmailTextFormField(false),
            const SizedBox(
              height: defaultSpacing,
            ),
            SignUpPasswordTextFormField(false),
            const SizedBox(
              height: defaultSpacing,
            ),
            Form(
              key: verifyFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerifySignUpTextFormField(),
                  SizedBox(
                    height: 30,
                  ),
                  verifySignUpButton(context: context, text: "Verify", isLoading: isLoading, verifyFormKey: verifyFormKey),
                  const SizedBox(
                    height: smallSpacing,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?", style: TextStyle(fontSize: defaultFontSize, color: onBackgroundColor, fontWeight: FontWeight.w500),),
                TextButton(
                    onPressed: () {
                      context.push('/login');
                    },
                    child: normalText(value: "Sign In", size: defaultFontSize, color: primaryColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
