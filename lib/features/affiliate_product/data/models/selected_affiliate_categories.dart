import 'package:flutter/material.dart';

class SelectedAffiliateCategory extends ChangeNotifier {
  int index = 0;

  void selectedIndex(int index){
    this.index = index;
    notifyListeners();
  }

}