import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/features/common_widgets/grid_image.dart';
import 'package:cash_app/features/common_widgets/order_dialog.dart';
import 'package:cash_app/features/products/data/models/products.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget allProductsBox({required BuildContext context, required Products product}){
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
          product.mainImage!.path == "null" ?
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              image: DecorationImage(
                  image: AssetImage("images/default.png"),
                  fit: BoxFit.cover),
            ),
          ) : ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: gridImage(urlImage: "$baseUrl${product.mainImage!.path}")),
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
                        backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return orderDialog(context: context, product: product);
                            });
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