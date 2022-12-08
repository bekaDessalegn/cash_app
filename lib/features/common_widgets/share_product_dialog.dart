import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:cash_app/features/affiliate_profile/presentation/widgets/promo_link_box.dart';
import 'package:cash_app/features/common_widgets/small_image.dart';
import 'package:cash_app/features/products/data/models/products.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/akar_icons.dart';
import 'package:colorful_iconify_flutter/icons/logos.dart';

TextEditingController shareProductController = TextEditingController();
final _prefs = PrefService();

Widget shareProductDialog({required BuildContext context, required Products product}) {

  return FutureBuilder(
      future: _prefs.readUserId(),
      builder: (context, snapshot){
      shareProductController.text = "$hostUrl/s_products?product_id=${product.productId}&aff=${snapshot.data.toString()}";
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: SizedBox(
          width: MediaQuery.of(context).size.width < 500 ? null : 400,
          height: 510,
          child: snapshot.hasData ? SingleChildScrollView(
            child: Column(
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
                      product.mainImage!.path == "null"
                          ? Container(
                        height: 138,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: AssetImage("images/default.png"),
                              fit: BoxFit.cover),
                        ),
                      )
                          : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: smallImage(urlImage: "$baseUrl${product.mainImage!.path}")),
                      SizedBox(height: 10,),
                      Text(
                        "${product.productName}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: onBackgroundColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Price",
                                style: TextStyle(
                                    color: onBackgroundColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${product.price} ETB",
                                style: TextStyle(
                                  color: onBackgroundColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Commission",
                                style: TextStyle(
                                    color: onBackgroundColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${product.commission} ETB",
                                style: TextStyle(
                                  color: onBackgroundColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Divider(color: surfaceColor, thickness: 1.0,),
                      SizedBox(height: 15,),
                      Text(
                        "Here is your link to share this product. Copy and share it arround your social networks.",
                        style: TextStyle(
                          color: onBackgroundColor,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                                onTap: (){
                                  share(socialPlatform: SocialMedia.facebook, shareLink: shareProductController.text);
                                },
                                child: Iconify(Logos.facebook, size: 23)),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                                onTap: (){
                                  share(socialPlatform: SocialMedia.whatsapp, shareLink: shareProductController.text);
                                },
                                child: Iconify(AkarIcons.whatsapp_fill, size: 23, color: Colors.green,)),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                                onTap: (){
                                  share(socialPlatform: SocialMedia.telegram, shareLink: shareProductController.text);
                                },
                                child: Iconify(Logos.telegram, size: 23)),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                                onTap: (){
                                  share(socialPlatform: SocialMedia.twitter, shareLink: shareProductController.text);
                                },
                                child: Iconify(Logos.twitter, size: 23)),),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                                onTap: (){
                                  share(socialPlatform: SocialMedia.linkedin, shareLink: shareProductController.text);
                                },
                                child: Iconify(Logos.linkedin_icon, size: 23)),)
                        ],
                      ),
                      SizedBox(height: 25,),
                      promoLinkBox(context: context, promoController: shareProductController),
                    ],
                  ),
                ),
              ],
            ),
          ) : Center(child: SizedBox(height: 30, width: 30, child: CircularProgressIndicator(color: primaryColor,))),
        ),
      );
  });
}
