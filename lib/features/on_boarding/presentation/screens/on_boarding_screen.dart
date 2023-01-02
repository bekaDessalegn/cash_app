import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatelessWidget {

  final _prefs = PrefService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(0, 60, 0, 10),
      child: IntroductionScreen(
        showNextButton: true,
        next: Iconify(Ic.baseline_navigate_next, color: onBackgroundColor,),
        showSkipButton: true,
        skip: Text("Skip"),
        pages: [
          PageViewModel(
            title: "Cash",
            body: "A machine shop for your furniture and metal works",
            image: SvgPicture.asset("images/onboard1.svg"),
            decoration: PageDecoration(
              titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: onBackgroundColor),
              bodyTextStyle: TextStyle(fontSize: 16, color: onBackgroundColor),
            )
          ),
          PageViewModel(
            title: "Sign up",
            body: "Work with us and earn some money",
            image: SvgPicture.asset("images/onboard2.svg"),
            decoration: PageDecoration(
              titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: onBackgroundColor),
              bodyTextStyle: TextStyle(fontSize: 16, color: onBackgroundColor),
            )
          ),
          PageViewModel(
            title: "Order",
            body: "Get the machine that you desire",
            image: SvgPicture.asset("images/onboard3.svg"),
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
      ),
    ));
  }
}
