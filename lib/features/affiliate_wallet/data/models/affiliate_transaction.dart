class AffiliateTransaction {
  final String? userId;
  final String? fullName;

  AffiliateTransaction({this.userId, this.fullName});

  factory AffiliateTransaction.fromJson(Map<String, dynamic> json) =>
      AffiliateTransaction(userId: json["userId"], fullName: json["fullName"]);
}
