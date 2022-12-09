import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:cash_app/features/home/presentation/widgets/home_body.dart';
import 'package:flutter/material.dart';

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({Key? key}) : super(key: key);

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {

  final _prefs = PrefService();

  @override
  void initState() {
    final affLink = Uri.base.queryParameters['aff'];
    if(affLink.toString() != "null"){
      _prefs.createAffiliateLink(affLink!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeBody(),
    );
  }
}
