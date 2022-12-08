import 'package:cash_app/core/constants.dart';
import 'package:flutter/material.dart';

Widget orderedList({required String number, required String text, required double fontSize}){
  return Padding(
    padding: const EdgeInsets.only(left: 0.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: TextStyle(
            color: onBackgroundColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(width: 10,),
        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.visible,
            style: TextStyle(
              color: onBackgroundColor,
              fontSize: fontSize,
            ),
          ),
        ),
      ],
    ),
  );
}