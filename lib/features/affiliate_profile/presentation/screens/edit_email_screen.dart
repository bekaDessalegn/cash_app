import 'package:cash_app/features/affiliate_profile/presentation/widgets/edit_email_body.dart';
import 'package:cash_app/features/common_widgets/affiliate_mobile_header.dart';
import 'package:cash_app/features/common_widgets/bottom_navigationbar.dart';
import 'package:flutter/material.dart';

class MobileEditEmailScreen extends StatefulWidget {
  const MobileEditEmailScreen({Key? key}) : super(key: key);

  @override
  State<MobileEditEmailScreen> createState() => _MobileEditEmailScreenState();
}

class _MobileEditEmailScreenState extends State<MobileEditEmailScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
          child: mobileAffiliateHeader(context: context),
          preferredSize: Size.fromHeight(84)),
      body: EditEmailBody(),
      bottomNavigationBar: bottomNavigationBar(context, 0),
    );
  }
}
