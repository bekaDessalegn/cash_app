import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/features/common_widgets/main_logo.dart';
import 'package:cash_app/features/home/data/models/header_items.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';

Widget detailEndDrawer({required BuildContext context, required int selectedIndex}){

  List<HeaderItem> headerItems = [
    HeaderItem(
      title: "Home",
      onTap: () {
        context.go('/');
      },
    ),
    HeaderItem(title: "Products", onTap: () {
      context.go('/products');
    }),
    HeaderItem(title: "About Us", onTap: () {
      context.go('/about_us');
    }),
    HeaderItem(title: "Contact Us", onTap: () {
      context.go('/contact_us');
    }),
  ];

  return Drawer(
    child: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(onPressed: (){
              detailScaffoldKey.currentState!.closeEndDrawer();
            }, icon: Iconify(Ep.close_bold)),
            Center(
              child: mainLogo(),
            ),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: (){
                    detailScaffoldKey.currentState!.closeEndDrawer();
                    headerItems[index].onTap();
                  },
                  title: Text(
                    headerItems[index].title,
                    style: TextStyle(
                        color: selectedIndex == index ? primaryColor : onBackgroundColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10.0,
                );
              },
              itemCount: headerItems.length,
            ),
            SizedBox(height: 30,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  onPressed: (){
                    context.go(APP_PAGE.signup.toPath);
                  },
                  child: Text("Sign up", style: TextStyle(color: onPrimaryColor, fontSize: 15),)),
            ),
            SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: backgroundColor,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                  onPressed: (){
                    context.go(APP_PAGE.login.toPath);
                  },
                  child: Text("Sign in", style: TextStyle(color: primaryColor, fontSize: 15),)),
            ),
          ],
        ),
      ),
    ),
  );
}