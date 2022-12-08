import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/features/affiliate_profile/presentation/blocs/affiliates_bloc.dart';
import 'package:cash_app/features/affiliate_profile/presentation/blocs/affiliates_state.dart';
import 'package:cash_app/features/affiliate_profile/presentation/widgets/confirm_change_password_button.dart';
import 'package:cash_app/features/common_widgets/error_flashbar.dart';
import 'package:cash_app/features/common_widgets/semi_bold_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditPasswordBody extends StatefulWidget {
  const EditPasswordBody({Key? key}) : super(key: key);

  @override
  State<EditPasswordBody> createState() => _EditPasswordBodyState();
}

class _EditPasswordBodyState extends State<EditPasswordBody> {

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final changePasswordFormKey = GlobalKey<FormState>();

  bool oldSecureText = true;
  bool newSecureText = true;
  bool confirmSecureText = true;

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<EditPasswordBloc, EditProfileState>(listener: (_, state) {
        if (state is EditPasswordFailed) {
          buildErrorLayout(context: context, message: state.errorType);
        } else if (state is EditPasswordSuccessful) {
          context.go(APP_PAGE.affiliateProfile.toPath);
        }
      }, builder: (_, state) {
        if (state is EditPasswordLoading) {
          return buildInitialInput(isLoading: true);
        } else {
          return buildInitialInput(isLoading: false);
        }
      }),
    );
  }

  Widget buildInitialInput({required bool isLoading}) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: SizedBox(
      width: 400,
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40,),
              semiBoldText(
                  value: "Changing your password",
                  size: 28,
                  color: onBackgroundColor),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: changePasswordFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: addProductVerticalSpacing,
                      ),
                      semiBoldText(
                          value: "Old Password",
                          size: defaultFontSize,
                          color: onBackgroundColor),
                      const SizedBox(
                        height: smallSpacing,
                      ),
                      TextFormField(
                        controller: oldPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Value can not be empty";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "",
                            hintStyle:
                            TextStyle(color: textInputPlaceholderColor),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 10.0),
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
                                  oldSecureText = !oldSecureText;
                                });
                              },
                              icon: Icon(
                                oldSecureText == true
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: onBackgroundColor,
                              ),
                            )),
                        obscureText: oldSecureText,
                      ),
                      const SizedBox(
                        height: addProductVerticalSpacing,
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
                            hintStyle:
                            TextStyle(color: textInputPlaceholderColor),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 10.0),
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
                      const SizedBox(
                        height: addProductVerticalSpacing,
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
                            hintStyle:
                            TextStyle(color: textInputPlaceholderColor),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 10.0),
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
                      const SizedBox(
                        height: 40,
                      ),
                      confirmChangePasswordButton(
                          context: context,
                          changePasswordFormKey: changePasswordFormKey,
                          oldPasswordController: oldPasswordController,
                          newPasswordController: newPasswordController,
                          confirmPasswordController: confirmPasswordController,
                          isLoading: isLoading
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );

  Widget buildLoadingLayout() => Center(
    child: CircularProgressIndicator(
      color: primaryColor,
    ),
  );
}
