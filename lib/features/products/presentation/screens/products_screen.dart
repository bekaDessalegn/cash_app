import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:cash_app/features/common_widgets/mobile_cookie_banner.dart';
import 'package:cash_app/features/common_widgets/mobile_end_drawer.dart';
import 'package:cash_app/features/products/presentation/widgets/product_body.dart';
import 'package:flutter/material.dart';

class MobileProductsScreen extends StatefulWidget {
  const MobileProductsScreen({Key? key}) : super(key: key);

  @override
  State<MobileProductsScreen> createState() => _MobileProductsScreenState();
}

class _MobileProductsScreenState extends State<MobileProductsScreen> {

  final _prefs = PrefService();

  @override
  void initState() {
    scaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        endDrawer: mobileEndDrawer(context: context, selectedIndex: 1),
        body: ProductBody()
    );
  }
}
