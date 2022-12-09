import 'dart:convert';

import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/features/about_us/data/models/about_content.dart';
import 'package:cash_app/features/about_us/presentation/blocs/about_us_bloc.dart';
import 'package:cash_app/features/about_us/presentation/blocs/about_us_event.dart';
import 'package:cash_app/features/about_us/presentation/blocs/about_us_state.dart';
import 'package:cash_app/features/about_us/presentation/widgets/how_to_affiliate_with_us_frame.dart';
import 'package:cash_app/features/about_us/presentation/widgets/ordered_list_widget.dart';
import 'package:cash_app/features/about_us/presentation/widgets/who_we_are_frame.dart';
import 'package:cash_app/features/common_widgets/error_box.dart';
import 'package:cash_app/features/common_widgets/error_flashbar.dart';
import 'package:cash_app/features/common_widgets/footer.dart';
import 'package:cash_app/features/home/presentation/widgets/bullet_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class AboutBody extends StatefulWidget {
  const AboutBody({Key? key}) : super(key: key);

  @override
  State<AboutBody> createState() => _AboutBodyState();
}

class _AboutBodyState extends State<AboutBody> {

  var howToBuyFromUsController = quill.QuillController.basic();
  var howToAffiliateWithUsController = quill.QuillController.basic();
  var whoAreWeDescriptionController = quill.QuillController.basic();
  var whyUsDescriptionController = quill.QuillController.basic();

  static String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }

  @override
  void initState() {
    final aboutUs = BlocProvider.of<AboutUsContentBloc>(context);
    aboutUs.add(GetAboutUsContentEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AboutUsContentBloc, AboutUsContentState>(
        listener: (_, state){
          if(state is GetAboutUsContentSuccessfulState){
            var whoAreWeDescriptionJSON = jsonDecode(state.aboutUsContent.whoAreWeDescription);
            whoAreWeDescriptionController = quill.QuillController(
                document: quill.Document.fromJson(whoAreWeDescriptionJSON),
                selection: TextSelection.collapsed(offset: 0));
            var whyUsDescriptionJSON = jsonDecode(state.aboutUsContent.whyUsDescription);
            whyUsDescriptionController = quill.QuillController(
                document: quill.Document.fromJson(whyUsDescriptionJSON),
                selection: TextSelection.collapsed(offset: 0));
            var howToAffiliateWithUsJSON = jsonDecode(state.aboutUsContent.howToAffiliateWithUsDescription);
            howToAffiliateWithUsController = quill.QuillController(
                document: quill.Document.fromJson(howToAffiliateWithUsJSON),
                selection: TextSelection.collapsed(offset: 0));
            var howToBuyFromUsJSON = jsonDecode(state.aboutUsContent.howToBuyFromUsDescription);
            howToBuyFromUsController = quill.QuillController(
                document: quill.Document.fromJson(howToBuyFromUsJSON),
                selection: TextSelection.collapsed(offset: 0));
          }
        },
        builder: (_, state) {
          if (state is GetAboutUsContentLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          } else if (state is GetAboutUsContentSuccessfulState) {
            return aboutBody(aboutUsContent: state.aboutUsContent);
          } else if (state is GetAboutUsContentFailedState) {
            return Center(
              child: SizedBox(
                height: 220,
                child: errorBox(onPressed: () {
                  final aboutUs = BlocProvider.of<AboutUsContentBloc>(context);
                  aboutUs.add(GetAboutUsContentEvent());
                }),
              ),
            );
          } else {
            return SizedBox();
          }
        });
  }

  Widget aboutBody({required AboutUsContent aboutUsContent}){
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage("$baseUrl${aboutUsContent.aboutUsImage.path}"), fit: BoxFit.cover),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Some words",
                    style: TextStyle(
                      color: surfaceColor,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "About Us",
                    style: TextStyle(
                        color: surfaceColor,
                        fontSize: 48,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Who are we?",
                  style: TextStyle(
                      color: onBackgroundColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "$baseUrl${aboutUsContent.whoAreWeImage.path}",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 160,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: double.infinity,
                        height: 160,
                        decoration: BoxDecoration(
                            border: Border.all(color: surfaceColor)
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10,),
                quill.QuillEditor.basic(controller: whoAreWeDescriptionController, readOnly: true),
                SizedBox(height: 40,),
                // WhoAreWeIframeScreen(url: convertUrlToId(aboutUsContent.whoAreWeVideoLink)!, frameHeight: 170, frameWidth: double.infinity,),
                SizedBox(height: 40,),
                Text(
                  "why us?",
                  style: TextStyle(
                    color: onBackgroundColor,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "${aboutUsContent.whyUsTitle}",
                  style: TextStyle(
                      color: onBackgroundColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                quill.QuillEditor.basic(controller: whyUsDescriptionController, readOnly: true),
                SizedBox(height: 17,),
                Image.network(
                  "$baseUrl${aboutUsContent.whyUsImage.path}",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 187,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: double.infinity,
                      height: 187,
                      decoration: BoxDecoration(
                          border: Border.all(color: surfaceColor)
                      ),
                    );
                  },
                ),
                SizedBox(height: 40,),
                Text(
                  "How to buy from us?",
                  style: TextStyle(
                      color: onBackgroundColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                quill.QuillEditor.basic(controller: howToBuyFromUsController, readOnly: true),
                SizedBox(height: 40,),
                Text(
                  "How to affiliate and earn with us?",
                  style: TextStyle(
                      color: onBackgroundColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                quill.QuillEditor.basic(controller: howToAffiliateWithUsController, readOnly: true),
                SizedBox(height: 10,),
                Text(
                  "We have a video for it",
                  style: TextStyle(
                    color: onBackgroundColor,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 10,),
                // HowToAffiliateWithUsFrame(url: convertUrlToId(aboutUsContent.howToAffiliateWithUsVideoLink)!, frameHeight: 170, frameWidth: double.infinity,),
                SizedBox(height: 25,),
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
                        "Explore products",
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
            ),
          ),
          SizedBox(height: 30,),
          footer(context: context)
        ],
      ),
    );
  }

}