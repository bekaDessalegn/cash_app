import 'package:cash_app/features/affiliate_wallet/data/models/affiliate_transaction.dart';
import 'package:cash_app/features/affiliate_wallet/data/models/reason.dart';

class Transactions {
  final String transactionId;
  final AffiliateTransaction affiliate;
  final num amount;
  final Reason reason;
  final String transactedAt;

  Transactions(
      {required this.transactionId,
        required this.affiliate,
        required this.amount,
        required this.reason,
        required this.transactedAt});

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
      transactionId: json["transactionId"],
      affiliate: AffiliateTransaction.fromJson(json["affiliate"]),
      amount: json["amount"],
      reason: Reason.fromJson(json["reason"]),
      transactedAt: json["transactedAt"]);
}