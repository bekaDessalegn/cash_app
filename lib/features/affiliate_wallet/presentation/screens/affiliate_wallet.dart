import 'package:cash_app/features/affiliate_wallet/presentation/widgets/wallet_body.dart';
import 'package:cash_app/features/common_widgets/affiliate_mobile_header.dart';
import 'package:cash_app/features/common_widgets/bottom_navigationbar.dart';
import 'package:flutter/material.dart';

class MobileAffiliateWalletScreen extends StatelessWidget {
  const MobileAffiliateWalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(child: mobileAffiliateHeader(context: context), preferredSize: Size.fromHeight(60)),
      body: WalletBody(),
      bottomNavigationBar: bottomNavigationBar(context, 2),
    );
  }
}
