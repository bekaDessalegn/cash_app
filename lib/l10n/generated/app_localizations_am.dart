import 'app_localizations.dart';

/// The translations for Amharic (`am`).
class PhoneFieldLocalizationAm extends PhoneFieldLocalization {
  PhoneFieldLocalizationAm([String locale = 'am']) : super(locale);

  @override
  String get language => 'አማርኛ';

  @override
  String get hello => 'ሰላም';

  @override
  String get admin => 'አስተዳዳሪ';

  @override
  String get sign_in_request => 'እባክዎ ወደ መለያዎ ይግቡ';

  @override
  String get username => 'የመጠቀሚያ ስም';

  @override
  String get password => 'የይለፍ ቃል';

  @override
  String get forgot_password => 'የይለፍ ቃል ረሳሁ';

  @override
  String get enter_password => 'የይለፍ ቃልዎን ያስገቡ';

  @override
  String get enter_your => 'የእርስዎን ያስገቡ';

  @override
  String get login => 'ግባ';
}
