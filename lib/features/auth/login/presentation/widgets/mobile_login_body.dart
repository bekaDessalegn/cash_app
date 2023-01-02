import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/core/services/auth_service.dart';
import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:cash_app/features/auth/login/presentation/blocs/signin_bloc.dart';
import 'package:cash_app/features/auth/login/presentation/blocs/signin_state.dart';
import 'package:cash_app/features/auth/login/presentation/widgets/login_button.dart';
import 'package:cash_app/features/auth/login/presentation/widgets/password_textformfield.dart';
import 'package:cash_app/features/auth/login/presentation/widgets/phone_textformfield.dart';
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

class MobileLoginBody extends StatelessWidget {

  final _prefs = PrefService();
  TextEditingController phoneOrEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return BlocConsumer<SignInBloc, SignInState>(
        listener: (_, state){
          if(state is SignInStateFailed){
            buildErrorLayout(context: context, message: state.errorType);
          }
          else if(state is SignInStateSuccessful){
            _prefs.createCache(password.text).whenComplete(() {
              authService.login();
              context.go(APP_PAGE.affiliateProducts.toPath);
            });
          }
        },
        builder: (_, state){
          if(state is SignInStateLoading){
            return buildInitialInput(context: context, isLoading: true);
          }
          else{
            return buildInitialInput(context: context, isLoading: false);
          }
        });
  }

  Widget buildInitialInput({required BuildContext context, required bool isLoading}){
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Form(
      key: formKey,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          height: h,
          width: w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: mainLogo()
              ),
              SizedBox(
                height: 50,
              ),
              Text("Sign In", style: TextStyle(color: onBackgroundColor, fontWeight: FontWeight.bold, fontSize: 40),),
              SizedBox(
                height: 10,
              ),
              normalText(value: "Please sign in to your account", size: defaultFontSize, color: onBackgroundColor),
              const SizedBox(
                height: mediumSpacing,
              ),
              phoneOrEmailWidget(),
              const SizedBox(
                height: defaultSpacing,
              ),
              const PasswordTextFormField(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      context.go(APP_PAGE.forgotPassword.toPath);
                    },
                    child: normalText(value: "Forgot your password?", size: defaultFontSize, color: primaryColor)),
              ),
              SizedBox(
                height: h / 20,
              ),
              loginButton(context: context, text: "Sign in", isLoading: isLoading),
              const SizedBox(
                height: smallSpacing,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No account?", style: TextStyle(fontSize: defaultFontSize, fontWeight: FontWeight.w500, color: onBackgroundColor),),
                  TextButton(
                      onPressed: () {
                        context.go('/signup');
                      },
                      child: normalText(value: "Create One", size: defaultFontSize, color: primaryColor)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
