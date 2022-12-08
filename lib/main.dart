import 'dart:async';

import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/provider/locale_provider.dart';
import 'package:cash_app/core/router/app_router.dart';
import 'package:cash_app/core/services/app_service.dart';
import 'package:cash_app/core/services/auth_service.dart';
import 'package:cash_app/features/about_us/data/datasources/about_us_datasource.dart';
import 'package:cash_app/features/about_us/data/repositories/about_us_repository.dart';
import 'package:cash_app/features/about_us/presentation/blocs/about_us_bloc.dart';
import 'package:cash_app/features/about_us/presentation/blocs/about_us_event.dart';
import 'package:cash_app/features/affiliate_product/data/models/selected_affiliate_categories.dart';
import 'package:cash_app/features/affiliate_profile/data/datasources/affiliates_datasource.dart';
import 'package:cash_app/features/affiliate_profile/data/repositories/affiliates_repository.dart';
import 'package:cash_app/features/affiliate_profile/presentation/blocs/affiliates_bloc.dart';
import 'package:cash_app/features/affiliate_profile/presentation/blocs/affiliates_event.dart';
import 'package:cash_app/features/affiliate_wallet/data/datasources/transaction_datasource.dart';
import 'package:cash_app/features/affiliate_wallet/data/repositories/transaction_repository.dart';
import 'package:cash_app/features/affiliate_wallet/presentation/blocs/transactions_bloc.dart';
import 'package:cash_app/features/auth/login/data/datasources/signin_datasource.dart';
import 'package:cash_app/features/auth/login/data/repositories/signin_repository.dart';
import 'package:cash_app/features/auth/login/presentation/blocs/signin_bloc.dart';
import 'package:cash_app/features/auth/signup/data/datasources/signup_datasource.dart';
import 'package:cash_app/features/auth/signup/data/repositories/signup_repository.dart';
import 'package:cash_app/features/auth/signup/presentation/blocs/signup_bloc.dart';
import 'package:cash_app/features/contact_us/data/datasources/contact_us_datasource.dart';
import 'package:cash_app/features/contact_us/data/repositories/contact_us_repository.dart';
import 'package:cash_app/features/contact_us/presentation/blocs/contact_us_bloc.dart';
import 'package:cash_app/features/home/data/datasources/home_datasource.dart';
import 'package:cash_app/features/home/data/repositories/home_repository.dart';
import 'package:cash_app/features/home/presentation/blocs/home_bloc.dart';
import 'package:cash_app/features/home/presentation/blocs/home_event.dart';
import 'package:cash_app/features/products/data/datasources/products_datasource.dart';
import 'package:cash_app/features/products/data/models/selectedCategory.dart';
import 'package:cash_app/features/products/data/repositories/products_repositories.dart';
import 'package:cash_app/features/products/presentation/blocs/categories/categories_bloc.dart';
import 'package:cash_app/features/products/presentation/blocs/products/products_bloc.dart';
import 'package:cash_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  usePathUrlStrategy();
  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatefulWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({
    Key? key,
    required this.sharedPreferences,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppService appService;
  late AuthService authService;
  late StreamSubscription<bool> authSubscription;

  @override
  void initState() {
    appService = AppService(widget.sharedPreferences);
    authService = AuthService();
    authSubscription = authService.onAuthStateChange.listen(onAuthStateChange);
    super.initState();
  }

  void onAuthStateChange(bool login) {
    appService.loginState = login;
  }

  @override
  void dispose() {
    authSubscription.cancel();
    super.dispose();
  }

  final homeRepository = HomeRepository(HomeDataSource());
  final aboutUsRepository = AboutUsRepository(AboutUsDataSource());
  final productsRepository = ProductsRepository(ProductsDataSource());
  final signUpRepository = SignUpRepository(SignUpDataSource());
  final signInRepository = SignInRepository(SignInDataSource());
  final affiliateRepository = AffiliatesRepository(AffiliatesDataSource());
  final transactionsRepository = TransactionRepository(TransactionDataSource());
  final contactUsRepository = ContactUsRepository(ContactUsDataSource());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NewInStoreBloc(homeRepository)..add(NewInStoreProductsEvent())),
        BlocProvider(create: (_) => FeaturedBloc(homeRepository)..add(FilterFeaturedEvent())),
        BlocProvider(create: (_) => TopSellerBloc(homeRepository)..add(FilterTopSellerEvent())),
        BlocProvider(create: (_) => HomeContentBloc(homeRepository)),
        BlocProvider(create: (_) => LogoImageBloc(homeRepository)..add(GetLogoImageEvent())),
        BlocProvider(create: (_) => FooterBloc(homeRepository)..add(GetFooterEvent())),
        BlocProvider(create: (_) => AboutUsContentBloc(aboutUsRepository)),
        BlocProvider(create: (_) => ProductsBloc(productsRepository)),
        BlocProvider(create: (_) => SingleProductBloc(productsRepository)),
        BlocProvider(create: (_) => SearchProductBloc(productsRepository)),
        BlocProvider(create: (_) => CategoriesBloc(productsRepository)),
        BlocProvider(create: (_) => SignUpBloc(signUpRepository)),
        BlocProvider(create: (_) => SignInBloc(signInRepository)),
        BlocProvider(create: (_) => SingleAffiliateBloc(affiliateRepository)..add(GetSingleAffiliateEvent())),
        BlocProvider(create: (_) => ChildrenBloc(affiliateRepository)),
        BlocProvider(create: (_) => ParentAffiliateBloc(affiliateRepository)),
        BlocProvider(create: (_) => PutAvatarBloc(affiliateRepository)),
        BlocProvider(create: (_) => PutEmailBloc(affiliateRepository)),
        BlocProvider(create: (_) => EditPasswordBloc(affiliateRepository)),
        BlocProvider(create: (_) => PatchPhoneBloc(affiliateRepository)),
        BlocProvider(create: (_) => PatchFullNameBloc(affiliateRepository)),
        BlocProvider(create: (_) => DeleteAffiliateBloc(affiliateRepository)),
        BlocProvider(create: (_) => OrdersBloc(productsRepository)),
        BlocProvider(create: (_) => AffiliateTransactionsBloc(transactionsRepository)),
        BlocProvider(create: (_) => ContactUsBloc(contactUsRepository)),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<AppService>(create: (_) => appService),
          Provider<AppRouter>(create: (_) => AppRouter(appService)),
          Provider<AuthService>(create: (_) => authService),
          ChangeNotifierProvider(create: (context) => LocaleProvider()),
          ChangeNotifierProvider(create: (_) => SelectedCategory()),
          ChangeNotifierProvider(create: (_) => SelectedAffiliateCategory()),
        ],
        child: Builder(
          builder: (context) {
            final GoRouter goRouter =
                Provider.of<AppRouter>(context, listen: false).router;

            final provider = Provider.of<LocaleProvider>(context);

            Map<int, Color> color = {
              50: Color.fromRGBO(136, 14, 79, .1),
              100: Color.fromRGBO(136, 14, 79, .2),
              200: Color.fromRGBO(136, 14, 79, .3),
              300: Color.fromRGBO(136, 14, 79, .4),
              400: Color.fromRGBO(136, 14, 79, .5),
              500: Color.fromRGBO(136, 14, 79, .6),
              600: Color.fromRGBO(136, 14, 79, .7),
              700: Color.fromRGBO(136, 14, 79, .8),
              800: Color.fromRGBO(136, 14, 79, .9),
              900: Color.fromRGBO(136, 14, 79, 1),
            };
            return MaterialApp.router(
              routeInformationProvider: goRouter.routeInformationProvider,
              routerDelegate: goRouter.routerDelegate,
              routeInformationParser: goRouter.routeInformationParser,
              debugShowCheckedModeBanner: false,
              title: 'cash_app',
              theme: ThemeData(
                primarySwatch: MaterialColor(0xFFF57721, color),
                scaffoldBackgroundColor: backgroundColor,
                textTheme: GoogleFonts.quicksandTextTheme(
                  Theme.of(context).textTheme,
                ),
              ),
              locale: provider.locale,
              supportedLocales: L10n.all,
              localizationsDelegates: [
                // AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
            );
          },
        ),
      ),
    );
  }
}
