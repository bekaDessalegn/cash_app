import 'package:cash_app/features/home/data/models/image.dart';

class AboutUsContent {
  final ImageContent heroImage;
  final String heroShortTitle;
  final String heroLongTitle;
  final String heroDescription;
  final ImageContent whoAreWeImage;
  final String whoAreWeDescription;
  final String whoAreWeVideoLink;
  final String howToBuyFromUsDescription;
  final String howToAffiliateWithUsDescription;
  final String howToAffiliateWithUsVideoLink;

  AboutUsContent({required this.heroImage,
    required this.heroShortTitle,
    required this.heroLongTitle,
    required this.heroDescription,
    required this.whoAreWeImage,
    required this.whoAreWeDescription,
    required this.whoAreWeVideoLink,
    required this.howToBuyFromUsDescription,
    required this.howToAffiliateWithUsDescription,
    required this.howToAffiliateWithUsVideoLink});

  factory AboutUsContent.fromJson(Map<String, dynamic> json) =>
      AboutUsContent(
          heroImage: ImageContent.fromJson(json["heroImage"]),
          heroShortTitle: json["heroShortTitle"],
          heroLongTitle: json["heroLongTitle"],
          heroDescription: json["heroDescription"],
          whoAreWeImage: ImageContent.fromJson(json["whoAreWeImage"]),
          whoAreWeDescription: json["whoAreWeDescription"],
          whoAreWeVideoLink: json["whoAreWeVideoLink"],
          howToBuyFromUsDescription: json["howToBuyFromUsDescription"],
          howToAffiliateWithUsDescription: json["howToAffiliateWithUsDescription"],
          howToAffiliateWithUsVideoLink: json["howToAffiliateWithUsVideoLink"]);
}
