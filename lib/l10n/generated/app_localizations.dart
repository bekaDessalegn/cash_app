import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_am.dart';
import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of PhoneFieldLocalization
/// returned by `PhoneFieldLocalization.of(context)`.
///
/// Applications need to include `PhoneFieldLocalization.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: PhoneFieldLocalization.localizationsDelegates,
///   supportedLocales: PhoneFieldLocalization.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the PhoneFieldLocalization.supportedLocales
/// property.
abstract class PhoneFieldLocalization {
  PhoneFieldLocalization(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static PhoneFieldLocalization? of(BuildContext context) {
    return Localizations.of<PhoneFieldLocalization>(context, PhoneFieldLocalization);
  }

  static const LocalizationsDelegate<PhoneFieldLocalization> delegate = _PhoneFieldLocalizationDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('am'),
    Locale('en')
  ];

  /// The current Language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;

  /// A program greetings
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// Admin
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get admin;

  /// Asking the user to sign in
  ///
  /// In en, this message translates to:
  /// **'Please sign in to your account'**
  String get sign_in_request;

  /// Username
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// Password
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Forgot password
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgot_password;

  /// Enter password
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enter_password;

  /// Enter your
  ///
  /// In en, this message translates to:
  /// **'Enter your'**
  String get enter_your;

  /// Login
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;
}

class _PhoneFieldLocalizationDelegate extends LocalizationsDelegate<PhoneFieldLocalization> {
  const _PhoneFieldLocalizationDelegate();

  @override
  Future<PhoneFieldLocalization> load(Locale locale) {
    return SynchronousFuture<PhoneFieldLocalization>(lookupPhoneFieldLocalization(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['am', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_PhoneFieldLocalizationDelegate old) => false;
}

PhoneFieldLocalization lookupPhoneFieldLocalization(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'am': return PhoneFieldLocalizationAm();
    case 'en': return PhoneFieldLocalizationEn();
  }

  throw FlutterError(
    'PhoneFieldLocalization.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
