import 'package:cash_app/core/constants.dart';
import 'package:cash_app/features/common_widgets/order_dialog.dart';
import 'package:cash_app/features/products/data/models/products.dart';
import 'package:flutter/material.dart';

Widget orderButton({required BuildContext context, required Products product}){
  return GestureDetector(
    onTap: (){
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context){
            return orderDialog(context: context, product: product);
          });
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "Order",
        style: TextStyle(
          color: onPrimaryColor,
          fontSize: 14,
        ),
      ),
    ),
  );
}