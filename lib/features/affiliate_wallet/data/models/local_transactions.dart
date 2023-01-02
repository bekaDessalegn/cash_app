class LocalTransactions {
  final String transactionId;
  final String kind;
  final num amount;
  final String transactedAt;

  LocalTransactions(
      {required this.transactionId,
      required this.kind,
      required this.amount,
      required this.transactedAt});

  factory LocalTransactions.fromJson(Map<String, dynamic> json) =>
      LocalTransactions(
          transactionId: json["transactionId"],
          kind: json["kind"],
          amount: json["amount"],
          transactedAt: json["transactedAt"]);

  Map<String, dynamic> toJson() => {
    "transactionId": transactionId,
    "kind": kind,
    "amount": amount,
    "transactedAt": transactedAt
  };
}
