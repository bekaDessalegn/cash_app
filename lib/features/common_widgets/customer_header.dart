import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/features/common_widgets/main_logo.dart';
import 'package:cash_app/features/common_widgets/share_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget customerHeader({required BuildContext context}){
  return SafeArea(
    child: Padding(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
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
              Row(
                children: [
                  TextButton(onPressed: (){
                    context.go(APP_PAGE.login.toPath);
                  }, child: Text("Sign in")),
                  TextButton(onPressed: (){
                    context.go(APP_PAGE.signup.toPath);
                  }, child: Text("Sign up")),
                ],
              )
            ],
          ),
          Divider(color: surfaceColor, thickness: 1.0,)
        ],
      ),
    ),
  );
}