import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/features/common_widgets/order_button.dart';
import 'package:cash_app/features/common_widgets/share_product_dialog.dart';
import 'package:cash_app/features/common_widgets/small_image.dart';
import 'package:cash_app/features/products/data/models/products.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget affiliateProductsBox({required BuildContext context, required Products product}) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: () {
        context.goNamed(APP_PAGE.affiliateProductDetails.toName, params: {'affiliate_product_id': product.productId!},);
      },
      child: Container(
        width: 249,
        height: 338,
        margin: EdgeInsets.fromLTRB(0, 10, 30, 10),
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
              height: 139,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("$baseUrl${product.mainImage!.path}"),
                      fit: BoxFit.cover),
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(10))),
            ) : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: smallImage(urlImage: "$baseUrl${product.mainImage!.path}")),
            SizedBox(
              height: 30,
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
                        fontSize: 16,
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
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Commission ",
                        style: TextStyle(
                            color: onBackgroundColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "${product.commission} ETB",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: onBackgroundColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return shareProductDialog(context: context, product: product);
                          });
                    },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.symmetric(vertical: 5)
                        ),
                        child: Text("Share", style: TextStyle(color: onPrimaryColor, fontSize: 16),)),
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
