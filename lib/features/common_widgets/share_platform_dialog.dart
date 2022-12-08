import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:cash_app/features/affiliate_profile/presentation/widgets/promo_link_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/akar_icons.dart';
import 'package:colorful_iconify_flutter/icons/logos.dart';

TextEditingController sharePlatformController = TextEditingController();
final _prefs = PrefService();

Widget sharePlatformDialog({required BuildContext context}) {

  return FutureBuilder(
    future: _prefs.readUserId(),
    builder: (context, snapshot){
        print("This is the final destination");
        print(snapshot.data);
        sharePlatformController.text = "$hostUrl/?aff=${snapshot.data.toString()}";
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: SizedBox(
            width: MediaQuery.of(context).size.width < 500 ? null : 400,
            height: 480,
            child: snapshot.hasData ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0, top: 10),
                      child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.close, size: 23, color: onBackgroundColor,))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 162,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("images/about.png"), fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "cash_app",
                                  style: GoogleFonts.aclonica(
                                    color: surfaceColor,
                                    fontSize: 40,
                                  ),
                                ),
                                Text(
                                  "A machine shop for your furniture and metal works",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: surfaceColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Divider(color: surfaceColor, thickness: 1.0,),
                        SizedBox(height: 15,),
                        Text(
                          "Here is your link to share the whole platform. Copy and share it arround your social networks.",
                          style: TextStyle(
                            color: onBackgroundColor,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: (){
                                  share(socialPlatform: SocialMedia.facebook, shareLink: sharePlatformController.text);
                                },
                                child: Iconify(Logos.facebook, size: 23,)),
                            GestureDetector(
                                onTap: (){
                                  share(socialPlatform: SocialMedia.whatsapp, shareLink: sharePlatformController.text);
                                },
                                child: Iconify(AkarIcons.whatsapp_fill, size: 23, color: Colors.green,)),
                            GestureDetector(
                                onTap: (){
                                  share(socialPlatform: SocialMedia.telegram, shareLink: sharePlatformController.text);
                                },
                                child: Iconify(Logos.telegram, size: 23)),
                            GestureDetector(
                                onTap: (){
                                  share(socialPlatform: SocialMedia.twitter, shareLink: sharePlatformController.text);
                                },
                                child: Iconify(Logos.twitter, size: 23,)),
                            GestureDetector(
                                onTap: (){
                                  share(socialPlatform: SocialMedia.linkedin, shareLink: sharePlatformController.text);
                                },
                                child: Iconify(Logos.linkedin_icon, size: 23,)),
                          ],
                        ),
                        SizedBox(height: 25,),
                        promoLinkBox(context: context, promoController: sharePlatformController),
                      ],
                    ),
                  ),
                ],
              ),
            ) : Center(child: SizedBox(height: 30, width: 30, child: CircularProgressIndicator(color: primaryColor,))),
          ),
        );
    },
  );
}
