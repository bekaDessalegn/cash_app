import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/features/auth/login/presentation/screens/login_screen.dart';
import 'package:cash_app/features/auth/signup/presentation/screens/signup_screen.dart';
import 'package:cash_app/features/common_widgets/main_logo.dart';
import 'package:cash_app/features/common_widgets/share_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';

Widget customerHeader({required BuildContext context}){
  return SafeArea(
    child: Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: surfaceColor, width: 1.0))
      ),
      padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: (){
                    context.go(APP_PAGE.product.toPath);
                  },
                  child: mainLogo()),
              IconButton(
                  padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MobileLoginScreen()));
                  },
                  icon: Iconify(
                    Bx.user,
                    size: 30,
                  ))
            ],
          ),
        ],
      ),
    ),
  );
}