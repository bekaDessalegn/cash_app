import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/features/common_widgets/main_logo.dart';
import 'package:cash_app/features/common_widgets/share_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget mobileAffiliateHeader({required BuildContext context}){
  return SafeArea(
    child: Container(
      padding: EdgeInsets.fromLTRB(0, 5, 15, 0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: surfaceColor, width: 1.0)
        )
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: (){
                    context.go(APP_PAGE.affiliateProducts.toPath);
                  },
                  child: mainLogo()),
              shareButton(context: context)
            ],
          ),
        ],
      ),
    ),
  );
}