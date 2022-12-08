import 'package:flutter/material.dart';

class HeaderItem {
  final String title;
  final VoidCallback onTap;

  HeaderItem({
    required this.title,
    required this.onTap
  });
}
