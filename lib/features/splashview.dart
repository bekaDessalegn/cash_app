import 'dart:async';

import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/core/services/app_service.dart';
import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  final _prefs = PrefService();
  late AppService _appService;

  @override
  void initState() {

    Timer(Duration(seconds: 2), () {
      _appService = Provider.of<AppService>(context, listen: false);
      onStartUp();
      _prefs.readCache().then((value) {
        if(value != null){
          context.go(APP_PAGE.affiliateProducts.toPath);
        }
        else{
          context.go(APP_PAGE.product.toPath);
        }
      });
    });
    super.initState();
  }

  void onStartUp() async {
    await _appService.onAppStart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("images/logo.png"),
      ),
    );
  }
}
