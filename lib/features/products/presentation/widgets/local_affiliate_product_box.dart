import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/features/common_widgets/blink_container.dart';
import 'package:cash_app/features/common_widgets/order_button.dart';
import 'package:cash_app/features/common_widgets/share_product_dialog.dart';
import 'package:cash_app/features/common_widgets/small_image.dart';
import 'package:cash_app/features/products/data/models/local_products.dart';
import 'package:cash_app/features/products/data/models/products.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget localAffiliateProductsBox({required BuildContext context, required LocalProducts product}) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: () {
        context.goNamed(APP_PAGE.affiliateProductDetails.toName, params: {'affiliate_product_id': product.productId},);
      },
      child: Container(
        width: 249,
        height: 338,
        margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlinkContainer(width: double.infinity, height: 130, borderRadius: 3,),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 180,
                    child: Text(
                      "${product.productName}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: onBackgroundColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${product.price} ETB",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: onBackgroundColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    "Commission ",
                    style: TextStyle(
                        color: onBackgroundColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    "${product.commission} ETB",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: onBackgroundColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 25,),
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: (){
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: textInputPlaceholderColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text("Share", style: TextStyle(color: onPrimaryColor, fontSize: 14),)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
