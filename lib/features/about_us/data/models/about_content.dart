import 'package:cash_app/features/home/data/models/image.dart';

class AboutUsContent {
  final ImageContent aboutUsImage;
  final ImageContent whyUsImage;
  final String whyUsTitle;
  final String whyUsDescription;
  final ImageContent whoAreWeImage;
  final String whoAreWeDescription;
  final String whoAreWeVideoLink;
  final String howToBuyFromUsDescription;
  final String howToAffiliateWithUsDescription;
  final String howToAffiliateWithUsVideoLink;

  AboutUsContent({required this.aboutUsImage,
    required this.whyUsImage,
    required this.whyUsTitle,
    required this.whyUsDescription,
    required this.whoAreWeImage,
    required this.whoAreWeDescription,
    required this.whoAreWeVideoLink,
    required this.howToBuyFromUsDescription,
    required this.howToAffiliateWithUsDescription,
    required this.howToAffiliateWithUsVideoLink});

  factory AboutUsContent.fromJson(Map<String, dynamic> json) =>
      AboutUsContent(
          aboutUsImage: ImageContent.fromJson(json["aboutUsImage"]),
          whyUsImage: ImageContent.fromJson(json["whyUsImage"]),
          whyUsTitle: json["whyUsTitle"],
          whyUsDescription: json["whyUsDescription"],
          whoAreWeImage: ImageContent.fromJson(json["whoAreWeImage"]),
          whoAreWeDescription: json["whoAreWeDescription"],
          whoAreWeVideoLink: json["whoAreWeVideoLink"],
          howToBuyFromUsDescription: json["howToBuyFromUsDescription"],
          howToAffiliateWithUsDescription: json["howToAffiliateWithUsDescription"],
          howToAffiliateWithUsVideoLink: json["howToAffiliateWithUsVideoLink"]);
}
