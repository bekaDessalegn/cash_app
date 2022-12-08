import 'package:cash_app/core/constants.dart';
import 'package:cash_app/features/auth/signup/presentation/blocs/signup_bloc.dart';
import 'package:cash_app/features/auth/signup/presentation/blocs/signup_event.dart';
import 'package:cash_app/features/auth/signup/presentation/widgets/mobile_signup_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileSignUpScreen extends StatefulWidget {
  const MobileSignUpScreen({Key? key}) : super(key: key);

  @override
  State<MobileSignUpScreen> createState() => _MobileSignUpScreenState();
}

class _MobileSignUpScreenState extends State<MobileSignUpScreen> {

  @override
  void initState() {
    final startSignUp = BlocProvider.of<SignUpBloc>(context);
    startSignUp.add(InitialSignUpEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      body: SafeArea(child: SingleChildScrollView(child: MobileSignUpBody())),
    );
  }
}
