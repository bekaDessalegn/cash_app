import 'package:cash_app/features/affiliate_profile/data/models/affiliation_summary.dart';
import 'package:cash_app/features/affiliate_profile/data/models/avatar.dart';
import 'package:cash_app/features/affiliate_profile/data/models/wallet.dart';

class Affiliates {
  final String? userId;
  final String fullName;
  final String phone;
  final String email;
  final Avatar? avatar;
  final String? parentId;
  final Wallet wallet;
  final AffiliationSummary affiliationSummary;
  final String? memberSince;

  Affiliates(
      {this.userId,
      required this.fullName,
      required this.phone,
      required this.email,
      this.avatar,
      this.parentId,
      required this.wallet,
      required this.affiliationSummary,
      this.memberSince});

  factory Affiliates.fromJson(Map<String, dynamic> json) => Affiliates(
      userId: json["userId"],
      fullName: json["fullName"],
      phone: json["phone"],
      email: json["email"],
      avatar: json["avatar"].toString() == "null"
          ? Avatar.fromJson({"path": "null"})
          : Avatar.fromJson(json["avatar"]),
      parentId: json["parentId"],
      wallet: Wallet.fromJson(json["wallet"]),
      affiliationSummary:
          AffiliationSummary.fromJson(json["affiliationSummary"]),
      memberSince: json["memberSince"]);

  Map<String, dynamic> toJson() => {
    "userId" : userId,
    "fullName" : fullName,
    "phone" : phone,
    "email" : email,
    "avatar" : avatar,
    "parentId" : parentId,
    "wallet" : wallet,
    "affiliationSummary" : affiliationSummary,
    "memberSince" : memberSince
  };
}
