import 'dart:convert';

import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/core/services/app_service.dart';
import 'package:cash_app/features/about_us/presentation/screens/about_us_screen.dart';
import 'package:cash_app/features/affiliate_product/presentation/screens/affiliate_product.dart';
import 'package:cash_app/features/affiliate_product/presentation/screens/affiliate_product_details.dart';
import 'package:cash_app/features/affiliate_profile/presentation/screens/affiliate_profile.dart';
import 'package:cash_app/features/affiliate_profile/presentation/screens/edit_email_screen.dart';
import 'package:cash_app/features/affiliate_profile/presentation/screens/edit_password_screen.dart';
import 'package:cash_app/features/affiliate_wallet/presentation/screens/affiliate_wallet.dart';
import 'package:cash_app/features/auth/login/presentation/screens/forgot_password_screen.dart';
import 'package:cash_app/features/auth/login/presentation/screens/login_screen.dart';
import 'package:cash_app/features/auth/login/presentation/screens/recovery_password_screen.dart';
import 'package:cash_app/features/auth/signup/presentation/screens/signup_screen.dart';
import 'package:cash_app/features/contact_us/presentation/screens/contact_us_screen.dart';
import 'package:cash_app/features/error_screen.dart';
import 'package:cash_app/features/home/presentation/screens/home_screen.dart';
import 'package:cash_app/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:cash_app/features/products/presentation/screens/product_details.dart';
import 'package:cash_app/features/products/presentation/screens/products_screen.dart';
import 'package:cash_app/features/products/presentation/screens/shared_product_details.dart';
import 'package:cash_app/features/splashview.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRouter {
  late final AppService appService;

  GoRouter get router => _goRouter;

  AppRouter(this.appService);

  late final GoRouter _goRouter = GoRouter(
      refreshListenable: appService,
      initialLocation: APP_PAGE.splash.toPath,
      routes: <GoRoute>[
        GoRoute(
          path: APP_PAGE.home.toPath,
          name: APP_PAGE.home.toName,
          builder: (context, state) => const MobileHomeScreen(),
        ),
        GoRoute(
          path: APP_PAGE.splash.toPath,
          name: APP_PAGE.splash.toName,
          builder: (context, state) => const SplashView(),
        ),
        GoRoute(
          path: APP_PAGE.onBoarding.toPath,
          name: APP_PAGE.onBoarding.toName,
          builder: (context, state) => OnBoardingScreen(),
        ),
        GoRoute(
          path: APP_PAGE.login.toPath,
          name: APP_PAGE.login.toName,
          builder: (context, state) => const MobileLoginScreen(),
        ),
        GoRoute(
          path: APP_PAGE.signup.toPath,
          name: APP_PAGE.signup.toName,
          builder: (context, state) => const MobileSignUpScreen(),
        ),
        GoRoute(
          path: APP_PAGE.affiliateProfile.toPath,
          name: APP_PAGE.affiliateProfile.toName,
          builder: (context, state) => MobileAffiliateProfileScreen(),
        ),
        GoRoute(
          path: APP_PAGE.affiliateProducts.toPath,
          name: APP_PAGE.affiliateProducts.toName,
          routes: [
            GoRoute(
              path: ":affiliate_product_id",
              name: APP_PAGE.affiliateProductDetails.toName,
              builder: (context, state) {
                final productId = state.params['affiliate_product_id']!;
                return MobileAffiliateProductDetails(
                  productId: productId,
                );
              },
            ),
          ],
          builder: (context, state) => MobileAffiliateProductScreen(),
        ),
        GoRoute(
          path: APP_PAGE.affiliateWallet.toPath,
          name: APP_PAGE.affiliateWallet.toName,
          builder: (context, state) => const MobileAffiliateWalletScreen(),
        ),
        GoRoute(
            path: APP_PAGE.product.toPath,
            name: APP_PAGE.product.toName,
            routes: [
              GoRoute(
                  path: ':id',
                  name: APP_PAGE.productDetails.toName,
                  builder: (context, state) {
                    final productId = state.params['id']!;
                    return MobileProductDetails(productId);
                  })
            ],
            builder: (context, state) => MobileProductsScreen()),
        GoRoute(
          path: APP_PAGE.aboutUs.toPath,
          name: APP_PAGE.aboutUs.toName,
          builder: (context, state) => const MobileAboutUsScreen(),
        ),
        GoRoute(
            path: APP_PAGE.sharedProductDetails.toPath,
            name: APP_PAGE.sharedProductDetails.toName,
            builder: (context, state) {
              return MobileSharedProductDetails();
            }),
        GoRoute(
          path: APP_PAGE.contactUs.toPath,
          name: APP_PAGE.contactUs.toName,
          builder: (context, state) => const MobileContactUsScreen(),
        ),
        GoRoute(
          path: APP_PAGE.forgotPassword.toPath,
          name: APP_PAGE.forgotPassword.toName,
          builder: (context, state) => MobileForgotPasswordScreen(),
        ),
        GoRoute(
          path: APP_PAGE.recoveryPassword.toPath,
          name: APP_PAGE.recoveryPassword.toName,
          builder: (context, state) => MobileRecoveryPasswordScreen(),
        ),
        GoRoute(
          path: APP_PAGE.editEmail.toPath,
          name: APP_PAGE.editEmail.toName,
          builder: (context, state) => const MobileEditEmailScreen(),
        ),
        GoRoute(
          path: APP_PAGE.editPassword.toPath,
          name: APP_PAGE.editPassword.toName,
          builder: (context, state) => const MobileEditPasswordScreen(),
        ),
        GoRoute(
          path: APP_PAGE.error.toPath,
          name: APP_PAGE.error.toName,
          builder: (context, state) =>
              PageNotFoundScreen(error: state.extra.toString()),
        ),
      ],
      errorBuilder: (context, state) =>
          PageNotFoundScreen(error: state.error.toString()),
      redirect: (BuildContext context, GoRouterState state) async {

        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

        final profileLocation = state.namedLocation(APP_PAGE.affiliateProfile.toName);
        final walletLocation = state.namedLocation(APP_PAGE.affiliateWallet.toName);
        final loginLocation = state.namedLocation(APP_PAGE.login.toName);
        final signupLocation = state.namedLocation(APP_PAGE.signup.toName);
        final affiliateProductsLocation = state.namedLocation(APP_PAGE.affiliateProducts.toName);
        final homeLocation = state.namedLocation(APP_PAGE.home.toName);
        final boardingLocation = state.namedLocation(APP_PAGE.onBoarding.toName);
        final productsLocation = state.namedLocation(APP_PAGE.product.toName);
        final aboutUsLocation = state.namedLocation(APP_PAGE.aboutUs.toName);
        final contactUsLocation = state.namedLocation(APP_PAGE.contactUs.toName);
        final affiliateWalletLocation = state.namedLocation(APP_PAGE.affiliateWallet.toName);
        final splashLocation = state.namedLocation(APP_PAGE.splash.toName);

        final isLoggedIn = appService.loginState;

        final isGoingToLogin = state.subloc == loginLocation;
        final isGoingToSignup = state.subloc == signupLocation;
        final isGoingToHome = state.subloc == homeLocation;
        final isGoingToProductsLocation = state.subloc == productsLocation;
        final isGoingToAboutUsLocation = state.subloc == aboutUsLocation;
        final isGoingToContactUsLocation = state.subloc == contactUsLocation;
        final isGoingToSplashLocation = state.subloc == splashLocation;

        final isGoingToAffiliateWalletLocation = state.subloc == affiliateWalletLocation;

        final isGoingToAffiliateProduct = state.subloc == affiliateProductsLocation;
        final isGoingToWallet = state.subloc == walletLocation;
        final isGoingToProfile = state.subloc == profileLocation;

        // if(isGoingToHome || isGoingToProductsLocation || isGoingToAboutUsLocation || isGoingToContactUsLocation){
        //     return null;
        // }
        //
        // if(!isLoggedIn && isGoingToSignup){
        //   return null;
        // }
        //
        // if(!isLoggedIn && !isGoingToLogin){
        //   return loginLocation;
        // }

        if(isGoingToSplashLocation){
          return null;
        }

        final boarded = await sharedPreferences.getBool("onBoarding") ?? false;
        final loggedIn = await sharedPreferences.getBool(LOGIN_KEY) ?? false;

        print("IS Boarded");
        print(boarded);

        print("IS LOGGED IN");
        print(loggedIn);

        if(!boarded){
          return boardingLocation;
        }

        if(!loggedIn && (isGoingToAffiliateProduct || isGoingToProfile || isGoingToWallet)){
          return productsLocation;
        }

        if(loggedIn && (isGoingToAboutUsLocation || isGoingToContactUsLocation || isGoingToHome || isGoingToProductsLocation)){
          return affiliateProductsLocation;
        }

        if (loggedIn && isGoingToLogin) {
          return affiliateProductsLocation;
        } else if(loggedIn && isGoingToSignup){
          return affiliateProductsLocation;
        }

        if (MediaQuery.of(context).size.width >= 1100) {
          if (isGoingToWallet) {
            return profileLocation;
          }
        }
      }
      // redirect: (BuildContext context, GoRouterState state) {
      //   final loginLocation = state.namedLocation(APP_PAGE.login.toName);
      //   final homeLocation = state.namedLocation(APP_PAGE.home.toName);
      //   final splashLocation = state.namedLocation(APP_PAGE.splash.toName);
      //   final productsLocation = state.namedLocation(APP_PAGE.product.toName);
      //   // final productsDetailLocation = state.namedLocation(APP_PAGE.productDetails.toName);
      //   final aboutUsLocation = state.namedLocation(APP_PAGE.aboutUs.toName);
      //   final contactUsLocation = state.namedLocation(APP_PAGE.contactUs.toName);
      //   final signUpLocation = state.namedLocation(APP_PAGE.signup.toName);
      //
      //   final isLoggedIn = appService.loginState;
      //   final isInitialized = appService.initialized;
      //
      //
      //   final isGoingToLogin = state.subloc == loginLocation;
      //   final isGoingToInit = state.subloc == splashLocation;
      //   final isGoingToHome = state.subloc == homeLocation;
      //   final isGoingToProductsLocation = state.subloc == productsLocation;
      //   final isGoingToAboutUsLocation = state.subloc == aboutUsLocation;
      //   final isGoingToContactUsLocation = state.subloc == contactUsLocation;
      //   final isGoingToSignUpLocation = state.subloc == signUpLocation;
      //
      //   if(isGoingToHome || isGoingToProductsLocation || isGoingToAboutUsLocation || isGoingToContactUsLocation || isGoingToSignUpLocation){
      //     return null;
      //   }
      //
      //   // If not Initialized and not going to Initialized redirect to Splash
      //   if (!isInitialized && !isGoingToInit) {
      //     return splashLocation;
      //   }
      //
      //   // If not logged in and not going to login redirect to Login
      //   else if (isInitialized && !isLoggedIn && !isGoingToLogin) {
      //     return loginLocation;
      //   }
      //   // If all the scenarios are cleared but still going to any of that screen redirect to Home
      //   else if ((isLoggedIn && isGoingToLogin) || (isInitialized && isGoingToInit)) {
      //     return homeLocation;
      //   }
      //   else {
      //     // Else Don't do anything
      //     return null;
      //   }
      // },
      );
}
