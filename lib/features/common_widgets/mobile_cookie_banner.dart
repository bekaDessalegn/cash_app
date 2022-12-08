import 'package:another_flushbar/flushbar.dart';
import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:cash_app/features/common_widgets/privacy_policy_dialog.dart';
import 'package:flutter/material.dart';

final _prefs = PrefService();

Widget mobileCookieBanner({required BuildContext context}) =>
    Flushbar(
      flushbarStyle: FlushbarStyle.GROUNDED,
      flushbarPosition: FlushbarPosition.BOTTOM,
      messageText: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        child: Column(
          children: [
            Text("We use cookies to ensure this site runs smoothly. ", style: TextStyle(color: onPrimaryColor), textAlign: TextAlign.center,),
            SizedBox(height: 10,),
            TextButton(onPressed: (){
              showDialog(
                  context: context,
                  builder: (context) {
                    return privacyPolicyDialog(context: context);
                  });
            }, child: Text("Privacy Policy", style: TextStyle(color: primaryColor, decoration: TextDecoration.underline),)),
            SizedBox(height: 10,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 25)
                ),
                onPressed: (){
                  _prefs.createCookie("cookie accepted");
                  Navigator.pop(context);
                }, child: Text("Got it", style: TextStyle(color: onPrimaryColor),))
          ],),
      ),
    )..show(context);