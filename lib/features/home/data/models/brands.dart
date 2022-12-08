import 'package:cash_app/features/home/data/models/image.dart';

class Brands {
  final String id;
  final ImageContent logoImage;
  final String? link;
  final num? rank;

  Brands({required this.id, required this.logoImage, this.link, this.rank});

  factory Brands.fromJson(Map<String, dynamic> json) => Brands(
      id: json["id"],
      logoImage: ImageContent.fromJson(json["logoImage"]),
      link: json["link"] ?? "",
      rank: json["rank"]);
}
