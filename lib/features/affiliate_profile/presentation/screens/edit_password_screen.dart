import 'package:cash_app/features/affiliate_profile/presentation/widgets/edit_email_body.dart';
import 'package:cash_app/features/affiliate_profile/presentation/widgets/edit_password_body.dart';
import 'package:cash_app/features/common_widgets/affiliate_mobile_header.dart';
import 'package:cash_app/features/common_widgets/bottom_navigationbar.dart';
import 'package:flutter/material.dart';

class MobileEditPasswordScreen extends StatelessWidget {
  const MobileEditPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
          child: mobileAffiliateHeader(context: context),
          preferredSize: Size.fromHeight(60)),
      body: EditPasswordBody(),
      bottomNavigationBar: bottomNavigationBar(context, 0),
    );
  }
}
