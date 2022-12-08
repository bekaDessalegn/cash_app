import 'package:cash_app/core/constants.dart';
import 'package:cash_app/features/auth/login/presentation/widgets/mobile_login_body.dart';
import 'package:flutter/material.dart';

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      body: SafeArea(child: SingleChildScrollView(child: MobileLoginBody())),
    );
  }
}
