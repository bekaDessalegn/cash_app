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
      appBar: PreferredSize(child: customerHeader(context: context), preferredSize: Size.fromHeight(84)),
        body: SafeArea(child: AboutBody()),
      bottomNavigationBar: customerBottomNavigationBar(context, 1),
    );
  }
}
