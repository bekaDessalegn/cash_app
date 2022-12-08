import 'dart:convert';

import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/features/home/data/models/home_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class WhyUs extends StatefulWidget {
  HomeContent homeContent;

  WhyUs({required this.homeContent});

  @override
  State<WhyUs> createState() => _WhyUsState();
}

class _WhyUsState extends State<WhyUs> {
  var whyUsDescriptionController = quill.QuillController.basic();

  @override
  void initState() {
    var whyUsDescriptionJSON = jsonDecode(widget.homeContent.whyUsDescription);
    whyUsDescriptionController = quill.QuillController(
        document: quill.Document.fromJson(whyUsDescriptionJSON),
        selection: TextSelection.collapsed(offset: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "why us",
                    style: TextStyle(
                      color: onBackgroundColor,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    widget.homeContent.whyUsTitle,
                    style: TextStyle(
                        color: onBackgroundColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: quill.QuillEditor.basic(
                            controller: whyUsDescriptionController,
                            readOnly: true),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Expanded(
                child: Image.network(
              "$baseUrl${widget.homeContent.whyUsImage.path}",
              fit: BoxFit.cover,
              height: 400,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: surfaceColor)
                      ),
                    );
                  },
            )
            ),
          ],
        )
      ],
    );
  }
}
