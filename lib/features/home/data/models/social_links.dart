import 'package:cash_app/features/home/data/models/image.dart';

class SocialLinks{
  final String id;
  final ImageContent logoImage;
  final String? link;
  final num? rank;

  SocialLinks({required this.id, required this.logoImage, this.link, this.rank});

  factory SocialLinks.fromJson(Map<String, dynamic> json) => SocialLinks(
      id: json["id"],
      logoImage: ImageContent.fromJson(json["logoImage"]),
      link: json["link"],
      rank: json["rank"]);
}