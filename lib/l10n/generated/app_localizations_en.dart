import 'app_localizations.dart';

/// The translations for English (`en`).
class PhoneFieldLocalizationEn extends PhoneFieldLocalization {
  PhoneFieldLocalizationEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'English';

  @override
  String get hello => 'Hello';

  @override
  String get admin => 'Admin';

  @override
  String get sign_in_request => 'Please sign in to your account';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get forgot_password => 'Forgot your password?';

  @override
  String get enter_password => 'Enter your password';

  @override
  String get enter_your => 'Enter your';

  @override
  String get login => 'Login';
}
