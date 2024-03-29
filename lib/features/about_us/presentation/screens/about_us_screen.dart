import 'package:cash_app/features/about_us/presentation/widgets/about_body.dart';
import 'package:cash_app/features/common_widgets/customer_bottom_nav_bar.dart';
import 'package:cash_app/features/common_widgets/customer_header.dart';
import 'package:flutter/material.dart';

class MobileAboutUsScreen extends StatefulWidget {
  const MobileAboutUsScreen({Key? key}) : super(key: key);

  @override
  State<MobileAboutUsScreen> createState() => _MobileAboutUsScreenState();
}

class _MobileAboutUsScreenState extends State<MobileAboutUsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
        body: AboutBody(),
      bottomNavigationBar: customerBottomNavigationBar(context, 0),
    );
  }
}
