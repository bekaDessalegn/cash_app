import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/features/common_widgets/blink_container.dart';
import 'package:cash_app/features/common_widgets/grid_image.dart';
import 'package:cash_app/features/common_widgets/order_dialog.dart';
import 'package:cash_app/features/products/data/models/local_products.dart';
import 'package:cash_app/features/products/data/models/products.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget allLocalProductsBox({required BuildContext context, required LocalProducts product}){
  return GestureDetector(
    onTap: () {
      context.goNamed(APP_PAGE.productDetails.toName, params: {'id': product.productId!},);
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
          BlinkContainer(width: double.infinity, height: 200, borderRadius: 3,),
          SizedBox(
            height: 25,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "${product.productName}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: onBackgroundColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "${product.price} ETB",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: onBackgroundColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                        backgroundColor: textInputPlaceholderColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                    },
                    child: Text(
                      "Order",
                      style: TextStyle(
                        color: onPrimaryColor,
                        fontSize: 14,
                      ),
                    ),)
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}