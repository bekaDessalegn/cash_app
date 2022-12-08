import 'dart:convert';

import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/features/home/data/models/home_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class LandingPage extends StatefulWidget {
  HomeContent homeContent;

  LandingPage(this.homeContent);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var heroDescriptionController = quill.QuillController.basic();

  @override
  void initState() {
    var heroDescriptionJSON = jsonDecode(widget.homeContent.heroDescription);
    heroDescriptionController = quill.QuillController(
        document: quill.Document.fromJson(heroDescriptionJSON),
        selection: TextSelection.collapsed(offset: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.homeContent.heroShortTitle,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: onBackgroundColor,
                fontSize: 25,
              ),
            ),
            Text(
              widget.homeContent.heroLongTitle,
              style: TextStyle(
                  color: onBackgroundColor,
                  fontSize: 45,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            quill.QuillEditor.basic(
                controller: heroDescriptionController, readOnly: true),
            SizedBox(
              height: 70,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    context.go(APP_PAGE.product.toPath);
                  },
                  child: Text(
                    "Shop Now",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: onPrimaryColor,
                        fontSize: 20),
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: backgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: primaryColor)),
                  ),
                  onPressed: () {
                    context.go(APP_PAGE.signup.toPath);
                  },
                  child: Text(
                    "Earn with us",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontSize: 20),
                  )),
            ),
          ],
        )),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Image.network(
                "$baseUrl${widget.homeContent.heroImage.path}",
                height: 300,
                width: double.infinity,
                fit: BoxFit.fill,
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
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        )),
      ],
    );
  }
}
