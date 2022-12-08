import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/features/home/data/models/home_content.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/gg.dart';
import 'package:iconify_flutter/icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';

Widget partnersWidget({required HomeContent homeContent}) {
  return GridView.builder(
      itemCount: homeContent.brands.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, mainAxisExtent: 80),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: brandsSection(
              brandImageLink:
                  "$baseUrl${homeContent.brands[index]["logoImage"]["path"]}",
              brandUrl: "${homeContent.brands[index]["link"]}"),
        );
      });
}

Widget brandsSection(
    {required String brandImageLink, required String brandUrl}) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
        onTap: () async {
          final url = Uri.parse(brandUrl);

          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          }
        },
        child: Image.network(
          brandImageLink,
          fit: BoxFit.fitHeight,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(color: surfaceColor)
              ),
            );
          },
        )),
  );
}
