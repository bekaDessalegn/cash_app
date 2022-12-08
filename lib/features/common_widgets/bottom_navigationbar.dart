import 'package:cash_app/core/constants.dart';
import 'package:cash_app/features/affiliate_product/data/models/affiliate_header_items.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/majesticons.dart';

Widget bottomNavigationBar(BuildContext context, int index){

  List<AffiliateHeaderItem> headerItems = [
    AffiliateHeaderItem(title: "Profile", icon: Bx.user, onTap: (){
      context.go('/affiliate_profile');
    }),
    AffiliateHeaderItem(title: "Products", icon: Ph.package, onTap: (){
      context.go('/affiliate_products');
    }),
    AffiliateHeaderItem(title: "Wallet", icon: Majesticons.clipboard_list_line, onTap: (){
      context.go('/affiliate_wallet');
    }),
  ];

  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    backgroundColor: backgroundColor,
    selectedItemColor: primaryColor,
    currentIndex: index,
    iconSize: 28,
    onTap: (index){
      headerItems[index].onTap();
      // routes[index];
    },
    items: [
      BottomNavigationBarItem(
        icon: Iconify(Bx.user, color: index == 0 ? primaryColor : onBackgroundColor,),
        label: "Profile",
      ),
      BottomNavigationBarItem(
        icon: Iconify(Ph.package, color: index == 1 ? primaryColor : onBackgroundColor,),
        label: "Products",
      ),
      BottomNavigationBarItem(
        icon: Iconify(Majesticons.clipboard_list_line, color: index == 2 ? primaryColor : onBackgroundColor,),
        label: "Wallet",
      ),
    ],
  );
}