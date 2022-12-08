import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/features/common_widgets/main_logo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/eva.dart';

Widget buildMobileHeader({required BuildContext context}) {
  return SafeArea(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: surfaceColor, width: 1.0)
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: (){
                context.go(APP_PAGE.home.toPath);
              },
              child: mainLogo()),
          GestureDetector(
            onTap: () {
              scaffoldKey.currentState!.openEndDrawer();
            },
            child: Iconify(Eva.menu_outline, color: onBackgroundColor, size: 35,),
          )
        ],
      ),
    ),
  );
}