import 'package:cash_app/core/constants.dart';
import 'package:flutter/material.dart';

Widget wordsAboutUs(){
  return Container(
    color: surfaceColor,
    padding: EdgeInsets.symmetric(vertical: 30),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "Reliable",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: onBackgroundColor,
              fontSize: 25),
        ),
        Text(
          "|",
          style: TextStyle(
            color: primaryColor,
            fontSize: 30,
          ),
        ),
        Text(
          "Affordable",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: onBackgroundColor,
              fontSize: 25),
        ),
        Text(
          "|",
          style: TextStyle(
            color: primaryColor,
            fontSize: 30,
          ),
        ),
        Text(
          "Ontime",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: onBackgroundColor,
              fontSize: 25),
        ),
        Text(
          "|",
          style: TextStyle(
            color: primaryColor,
            fontSize: 30,
          ),
        ),
        Text(
          "Warranty",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: onBackgroundColor,
              fontSize: 25),
        )
      ],
    ),
  );
}