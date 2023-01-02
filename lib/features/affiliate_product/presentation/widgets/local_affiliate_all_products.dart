import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/features/common_widgets/blink_container.dart';
import 'package:cash_app/features/common_widgets/grid_image.dart';
import 'package:cash_app/features/common_widgets/share_product_dialog.dart';
import 'package:cash_app/features/products/data/models/local_products.dart';
import 'package:cash_app/features/products/data/models/products.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget localAffiliateAllProductsBox({required BuildContext context, required LocalProducts product}){
  return GestureDetector(
    onTap: () {
      context.goNamed(APP_PAGE.affiliateProductDetails.toName, params: {'affiliate_product_id': product.productId},);
    },
    child: SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Divider(
            color: surfaceColor,
            thickness: 1.0,
          ),
          SizedBox(
            height: 5,
          ),
          BlinkContainer(width: double.infinity, height: 200, borderRadius: 0,),
          SizedBox(
            height: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${product.productName}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: onBackgroundColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
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
              SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: (){
                },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: textInputPlaceholderColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10)
                    ),
                    child: Text("Share", style: TextStyle(color: onPrimaryColor, fontSize: 16),)),
              )
            ],
          ),
        ],
      ),
    ),
  );
}