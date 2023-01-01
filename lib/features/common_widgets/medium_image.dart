import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';

Widget mediumImage({required String urlImage}){
  return ProgressiveImage(
    placeholder: AssetImage('images/loading.png'),
    // size: 1.87KB
    thumbnail: NetworkImage(urlImage),
    // size: 1.29MB
    image: NetworkImage(urlImage),
    height: 130,
    width: double.infinity,
    fit: BoxFit.cover,
  );
}