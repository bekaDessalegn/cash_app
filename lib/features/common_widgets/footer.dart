import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/features/common_widgets/main_logo.dart';
import 'package:cash_app/features/common_widgets/privacy_policy_dialog.dart';
import 'package:cash_app/features/home/data/models/social_links.dart';
import 'package:cash_app/features/home/presentation/blocs/home_bloc.dart';
import 'package:cash_app/features/home/presentation/blocs/home_event.dart';
import 'package:cash_app/features/home/presentation/blocs/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

Widget footer({required BuildContext context}) {
  return BlocBuilder<FooterBloc, FooterState>(builder: (_, state) {
    if (state is GetFooterLoadingState) {
      return SizedBox();
    } else if (state is GetFooterSuccessfulState) {
      return footerBody(context: context, socialLinks: state.socialLinks);
    } else if (state is GetFooterFailedState) {
      return footerBody(context: context, socialLinks: []);
    } else {
      return SizedBox();
    }
  });
}

Widget footerBody(
    {required BuildContext context, required List<SocialLinks> socialLinks}) {
  return Container(
    color: surfaceColor.withOpacity(0.4),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [mainLogo(), socialLinksSection(socialLinks: socialLinks)],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: textInputPlaceholderColor,
          thickness: 1.0,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  context.go(APP_PAGE.product.toPath);
                },
                child: Text(
                  "Products",
                  style: TextStyle(color: onBackgroundColor, fontSize: 13),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.go(APP_PAGE.aboutUs.toPath);
              },
              child: Text(
                "About us",
                style: TextStyle(color: onBackgroundColor, fontSize: 13),
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  context.go(APP_PAGE.contactUs.toPath);
                },
                child: Text(
                  "Contact us",
                  style: TextStyle(color: onBackgroundColor, fontSize: 13),
                ),
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return privacyPolicyDialog(context: context);
                      });
                },
                child: Text(
                  "Privacy policy",
                  style: TextStyle(color: onBackgroundColor, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: textInputPlaceholderColor,
          thickness: 1.0,
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "© 2022 ",
              style: TextStyle(color: onBackgroundColor, fontSize: 12),
            ),
            Text(
              "cash_app",
              style: TextStyle(color: primaryColor, fontSize: 12),
            ),
            Text(
              "™. All Rights Reserved.",
              style: TextStyle(color: onBackgroundColor, fontSize: 12),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        )
      ],
    ),
  );
}

Widget socialLinksSection({required List<SocialLinks> socialLinks}) {
  return SizedBox(
    height: 30,
    child: ListView.builder(
        itemCount: socialLinks.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                    onTap: () async {
                      final url = Uri.parse("${socialLinks[index].link}");

                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                    },
                    child: Image.network(
                      "$baseUrl${socialLinks[index].logoImage.path}",
                      width: 30,
                      height: 30,
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: surfaceColor,
                              border: Border.all(color: surfaceColor)
                          ),
                        );
                      },
                    ))),
          );
        }),
  );
}
