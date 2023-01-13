import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/features/affiliate_product/data/models/affiliate_header_items.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:iconify_flutter/icons/teenyicons.dart';

Widget customerBottomNavigationBar(BuildContext context, int index){

  List<AffiliateHeaderItem> headerItems = [
    AffiliateHeaderItem(title: "Home", icon: Teenyicons.home_outline, onTap: (){
      context.go(APP_PAGE.aboutUs.toPath);
    }),
    AffiliateHeaderItem(title: "Products", icon: Ph.package, onTap: (){
      context.go(APP_PAGE.product.toPath);
    }),
    AffiliateHeaderItem(title: "Contact us", icon: Ic.outline_local_phone, onTap: (){
      context.go(APP_PAGE.contactUs.toPath);
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
        icon: Iconify(Teenyicons.home_outline, color: index == 0 ? primaryColor : onBackgroundColor,),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Iconify(Ph.package, color: index == 1 ? primaryColor : onBackgroundColor,),
        label: "Products",
      ),
      BottomNavigationBarItem(
        icon: Iconify(Ic.outline_local_phone, color: index == 2 ? primaryColor : onBackgroundColor,),
        label: "Contact us",
      )
    ],
  );
}