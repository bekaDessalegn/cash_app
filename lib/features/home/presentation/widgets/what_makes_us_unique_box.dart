import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/features/home/data/models/home_content.dart';
import 'package:cash_app/features/home/presentation/widgets/bullet_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget whatMakesUsUnique({required BuildContext context, required HomeContent homeContent}) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
              child: Image.network(
            "$baseUrl${homeContent.whatMakesUsUniqueImage.path}",
            fit: BoxFit.cover,
                height: 300,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: surfaceColor)
                    ),
                  );
                },
          )),
          SizedBox(
            width: 30,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What Makes Us Unique?",
                  style: TextStyle(
                      color: onBackgroundColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  itemCount: (homeContent.whatMakesUsUnique.length / 2).round(),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      final int first = index * 2;
                      final int? second = index * 2 < homeContent.whatMakesUsUnique.length - 1 ? first + 1 : null;
                      // return bulletList(text: "${homeContent.whatMakesUsUnique[index]}");
                      return Row(
                        children: [first, second].map((idx) {
                          return idx != null
                              ? Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: bulletList(text: "${homeContent.whatMakesUsUnique[idx]}"),
                            ),
                          )
                              : Expanded( flex: 1, child: Container(), );
                        }).toList(),
                      );
                    }),
                SizedBox(
                  height: 30,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      context.go(APP_PAGE.product.toPath);
                    },
                    child: Text(
                      "Browse Our Products",
                      style: TextStyle(
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    ],
  );
}
