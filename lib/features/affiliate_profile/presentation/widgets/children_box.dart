import 'package:cash_app/core/constants.dart';
import 'package:cash_app/features/affiliate_profile/data/models/children.dart';
import 'package:flutter/material.dart';

Widget childrenWidget({required Children child}){
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            "${child.fullName}",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          "${child.childrenCount} children",
          style: TextStyle(
            color: onBackgroundColor,
            fontSize: 16,),
        ),
      ],
    ),
  );
}