import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatelessWidget {

  final _prefs = PrefService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: IntroductionScreen(
      showNextButton: true,
      next: Iconify(Ic.baseline_navigate_next, color: onBackgroundColor,),
      showSkipButton: true,
      skip: Text("Skip"),
      pages: [
        PageViewModel(
          title: "It's me and you",
          body: "Lets do all the stupid shit that young kids do",
          image: Image.asset("images/account.jpg"),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: onBackgroundColor),
            bodyTextStyle: TextStyle(fontSize: 16, color: onBackgroundColor),
          )
        ),
        PageViewModel(
          title: "It's me and you",
          body: "Lets do all the stupid shit that young kids do",
          image: Image.asset("images/about.png"),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: onBackgroundColor),
            bodyTextStyle: TextStyle(fontSize: 16, color: onBackgroundColor),
          )
        ),
        PageViewModel(
          title: "It's me and you",
          body: "Lets do all the stupid shit that young kids do",
          image: Image.asset("images/contact_us.png"),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: onBackgroundColor),
            bodyTextStyle: TextStyle(fontSize: 16, color: onBackgroundColor),
          )
        ),
      ],
      done: Text("Get Started", style: TextStyle(color: onBackgroundColor, fontWeight: FontWeight.bold),),
      onDone: (){
        _prefs.createOnBoarding();
        context.go(APP_PAGE.product.toPath);
      },
    ));
  }
}
