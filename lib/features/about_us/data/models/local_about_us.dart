import 'package:cash_app/features/home/data/models/image.dart';

class LocalAboutUsContent {
  final String heroShortTitle;
  final String heroLongTitle;
  final String heroDescription;
  final String whoAreWeDescription;
  final String whoAreWeVideoLink;
  final String howToBuyFromUsDescription;
  final String howToAffiliateWithUsDescription;
  final String howToAffiliateWithUsVideoLink;

  LocalAboutUsContent({
    required this.heroShortTitle,
    required this.heroLongTitle,
    required this.heroDescription,
    required this.whoAreWeDescription,
    required this.whoAreWeVideoLink,
    required this.howToBuyFromUsDescription,
    required this.howToAffiliateWithUsDescription,
    required this.howToAffiliateWithUsVideoLink});

  factory LocalAboutUsContent.fromJson(Map<String, dynamic> json) =>
      LocalAboutUsContent(
          heroShortTitle: json["heroShortTitle"],
          heroLongTitle: json["heroLongTitle"],
          heroDescription: json["heroDescription"],
          whoAreWeDescription: json["whoAreWeDescription"],
          whoAreWeVideoLink: json["whoAreWeVideoLink"],
          howToBuyFromUsDescription: json["howToBuyFromUsDescription"],
          howToAffiliateWithUsDescription: json["howToAffiliateWithUsDescription"],
          howToAffiliateWithUsVideoLink: json["howToAffiliateWithUsVideoLink"]);

  Map<String, dynamic> toJson() => {
    "heroShortTitle": heroShortTitle,
    "heroLongTitle": heroLongTitle,
    "heroDescription": heroDescription,
    "whoAreWeDescription": whoAreWeDescription,
    "whoAreWeVideoLink": whoAreWeVideoLink,
    "howToBuyFromUsDescription": howToBuyFromUsDescription,
    "howToAffiliateWithUsDescription": howToAffiliateWithUsDescription,
    "howToAffiliateWithUsVideoLink": howToAffiliateWithUsVideoLink
  };
}
