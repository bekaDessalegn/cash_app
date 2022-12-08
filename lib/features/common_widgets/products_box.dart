import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/features/common_widgets/medium_image.dart';
import 'package:cash_app/features/common_widgets/order_button.dart';
import 'package:cash_app/features/products/data/models/products.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget productsBox({required BuildContext context, required Products product}) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: () {
        context.goNamed(APP_PAGE.productDetails.toName, params: {'id': product.productId!},);
      },
      child: Container(
        width: 300,
        height: 200,
        margin: EdgeInsets.fromLTRB(0, 10, 50, 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
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
            product.mainImage!.path == "null" ?
            Container(
              height: 165,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                image: DecorationImage(
                    image: AssetImage("images/default.png"),
                    fit: BoxFit.cover),
              ),
            ) : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: mediumImage(urlImage: "$baseUrl${product.mainImage!.path}")),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                  SizedBox(
                    width: 180,
                    child: Text(
                      "${product.productName}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: onBackgroundColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${product.price} ETB",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: onBackgroundColor,
                          fontSize: 16,
                        ),
                      ),
                      orderButton(context: context, product: product)
                    ],
                  ),
                  SizedBox(
                    height: 30,
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
