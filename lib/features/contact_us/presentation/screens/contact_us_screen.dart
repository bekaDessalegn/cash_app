import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:cash_app/features/common_widgets/mobile_cookie_banner.dart';
import 'package:cash_app/features/common_widgets/mobile_end_drawer.dart';
import 'package:cash_app/features/contact_us/presentation/widgets/contact_us_body.dart';
import 'package:flutter/material.dart';

class MobileContactUsScreen extends StatefulWidget {
  const MobileContactUsScreen({Key? key}) : super(key: key);

  @override
  State<MobileContactUsScreen> createState() => _MobileContactUsScreenState();
}

class _MobileContactUsScreenState extends State<MobileContactUsScreen> {

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
        endDrawer: mobileEndDrawer(context: context, selectedIndex: 3),
        body: ContactUsBody()
    );
  }
}
