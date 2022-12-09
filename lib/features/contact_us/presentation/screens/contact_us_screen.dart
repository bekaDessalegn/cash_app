import 'package:cash_app/features/common_widgets/customer_bottom_nav_bar.dart';
import 'package:cash_app/features/common_widgets/customer_header.dart';
import 'package:cash_app/features/contact_us/presentation/widgets/contact_us_body.dart';
import 'package:flutter/material.dart';

class MobileContactUsScreen extends StatefulWidget {
  const MobileContactUsScreen({Key? key}) : super(key: key);

  @override
  State<MobileContactUsScreen> createState() => _MobileContactUsScreenState();
}

class _MobileContactUsScreenState extends State<MobileContactUsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(child: customerHeader(context: context), preferredSize: Size.fromHeight(84)),
        body: SafeArea(child: ContactUsBody()),
      bottomNavigationBar: customerBottomNavigationBar(context, 2),
    );
  }
}
