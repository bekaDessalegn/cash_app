import 'package:cash_app/features/common_widgets/customer_bottom_nav_bar.dart';
import 'package:cash_app/features/common_widgets/customer_header.dart';
import 'package:cash_app/features/products/presentation/widgets/product_body.dart';
import 'package:flutter/material.dart';

class MobileProductsScreen extends StatefulWidget {
  const MobileProductsScreen({Key? key}) : super(key: key);

  @override
  State<MobileProductsScreen> createState() => _MobileProductsScreenState();
}

class _MobileProductsScreenState extends State<MobileProductsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(child: customerHeader(context: context), preferredSize: Size.fromHeight(60)),
        body: ProductBody(),
      bottomNavigationBar: customerBottomNavigationBar(context, 1),
    );
  }
}
