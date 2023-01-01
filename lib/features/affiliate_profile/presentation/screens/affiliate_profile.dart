import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/features/affiliate_profile/presentation/widgets/profile_body.dart';
import 'package:cash_app/features/affiliate_profile/presentation/widgets/promo_link_box.dart';
import 'package:cash_app/features/common_widgets/affiliate_mobile_header.dart';
import 'package:cash_app/features/common_widgets/bold_text.dart';
import 'package:cash_app/features/common_widgets/bottom_navigationbar.dart';
import 'package:cash_app/features/common_widgets/normal_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/eva.dart';

class MobileAffiliateProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
          child: mobileAffiliateHeader(context: context),
          preferredSize: Size.fromHeight(60)),
      body: SingleChildScrollView(child: ProfileBody()),
      bottomNavigationBar: bottomNavigationBar(context, 0),
    );
  }
}
