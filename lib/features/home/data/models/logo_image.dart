import 'package:cash_app/features/home/data/models/image.dart';

class LogoImage {
  final ImageContent logoImage;

  LogoImage({required this.logoImage});

  factory LogoImage.fromJson(Map<String, dynamic> json) =>
      LogoImage(logoImage: ImageContent.fromJson(json["logoImage"]));
}
