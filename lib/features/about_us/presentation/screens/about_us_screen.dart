import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:cash_app/features/about_us/presentation/widgets/about_body.dart';
import 'package:cash_app/features/common_widgets/mobile_cookie_banner.dart';
import 'package:cash_app/features/common_widgets/mobile_end_drawer.dart';
import 'package:flutter/material.dart';

class MobileAboutUsScreen extends StatefulWidget {
  const MobileAboutUsScreen({Key? key}) : super(key: key);

  @override
  State<MobileAboutUsScreen> createState() => _MobileAboutUsScreenState();
}

class _MobileAboutUsScreenState extends State<MobileAboutUsScreen> {

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
        endDrawer: mobileEndDrawer(context: context, selectedIndex: 2),
        body: AboutBody()
    );
  }
}
