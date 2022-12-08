import 'package:cash_app/core/constants.dart';
import 'package:flutter/material.dart';

Widget walletBox({required String value, required String type}){
  return Container(
    height: 104,
    padding: EdgeInsets.only(left: 20),
    decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(defaultRadius)
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Text(value,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: onBackgroundColor
                ),
              ),
            ),
            Column(
              children: [
                Text(" ETB",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: onBackgroundColor
                  ),
                ),
                SizedBox(height: 5,)
              ],
            ),
          ],
        ),
        Text(type,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 20,
              color: onBackgroundColor
          ),),
      ],
    ),
  );
}