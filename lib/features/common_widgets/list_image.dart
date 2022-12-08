import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';

Widget listImage({required String urlImage}){
  return Padding(
    padding: const EdgeInsets.only(right: 20.0),
    child: ProgressiveImage(
      placeholder: AssetImage('images/loading.png'),
      thumbnail: NetworkImage(urlImage),
      image: NetworkImage(urlImage),
      height: 120,
      width: 120,
      fit: BoxFit.cover,
    ),
  );
}