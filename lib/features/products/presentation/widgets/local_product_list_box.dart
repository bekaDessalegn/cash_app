import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/features/common_widgets/blink_container.dart';
import 'package:cash_app/features/common_widgets/order_button.dart';
import 'package:cash_app/features/products/data/models/local_products.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';

Widget localProductListBox({required BuildContext context, required LocalProducts product}) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: () {
        context.goNamed(APP_PAGE.productDetails.toName, params: {'id': product.productId!},);
      },
      child: Container(
        width: 300,
        height: 200,
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
                  SizedBox(height: 5,),
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
                    height: 0,
                  ),
                  Text(
                    "${product.price} ETB",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: onBackgroundColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                      width: double.infinity,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: textInputPlaceholderColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Order",
                          style: TextStyle(
                            color: onPrimaryColor,
                            fontSize: 14,
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 10,
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
