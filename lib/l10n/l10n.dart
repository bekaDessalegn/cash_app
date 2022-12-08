import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('am'),
    const Locale('fr', ''),
    const Locale('es', ''),
    const Locale('el', ''),
    const Locale('de', ''),
    const Locale('it', ''),
    const Locale('ru', ''),
    const Locale('sv', ''),
    const Locale('tr', ''),
    const Locale('zh', ''),
  ];

  static String getLanguage(String code){
    switch(code){
      case 'am':
        return 'አማርኛ';
      case 'en':
      default:
        return 'English';
    }
  }
}