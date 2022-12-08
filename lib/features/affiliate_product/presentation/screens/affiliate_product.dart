import 'package:cash_app/core/constants.dart';
import 'package:cash_app/features/affiliate_product/presentation/widgets/affiliate_all_product_box.dart';
import 'package:cash_app/features/affiliate_product/presentation/widgets/affiliate_product_body.dart';
import 'package:cash_app/features/affiliate_product/presentation/widgets/affiliate_product_box.dart';
import 'package:cash_app/features/common_widgets/affiliate_mobile_header.dart';
import 'package:cash_app/features/common_widgets/bottom_navigationbar.dart';
import 'package:cash_app/features/common_widgets/product_search_widget.dart';
import 'package:flutter/material.dart';

class MobileAffiliateProductScreen extends StatelessWidget {
  const MobileAffiliateProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(child: mobileAffiliateHeader(context: context), preferredSize: Size.fromHeight(84)),
      body: AffiliateProductBody(),
      bottomNavigationBar: bottomNavigationBar(context, 1),
    );
  }
}
