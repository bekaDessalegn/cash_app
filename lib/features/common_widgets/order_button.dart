import 'package:cash_app/core/constants.dart';
import 'package:cash_app/features/common_widgets/order_dialog.dart';
import 'package:cash_app/features/products/data/models/products.dart';
import 'package:flutter/material.dart';

Widget orderButton({required BuildContext context, required Products product}){
  return ElevatedButton(
    onPressed: () {
      showDialog(
        barrierDismissible: false,
          context: context,
          builder: (BuildContext context){
            return orderDialog(context: context, product: product);
          });
    },
    style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        )
    ),
    child: Text(
      "Order",
      style: TextStyle(
        color: onPrimaryColor,
        fontSize: 16,
      ),
    ),
  );
}