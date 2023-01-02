class LocalAffiliate {
  final String userId;
  final String fullName;
  final String phone;
  final String email;
  final num totalRequests;
  final num acceptedRequests;
  final num rejectedRequests;
  final num totalMade;
  final num currentBalance;
  final num canWithdrawAfter;
  final String memberSince;

  LocalAffiliate(
      {required this.userId,
      required this.fullName,
      required this.phone,
      required this.email,
      required this.totalRequests,
      required this.acceptedRequests,
      required this.rejectedRequests,
      required this.totalMade,
      required this.currentBalance,
      required this.canWithdrawAfter,
      required this.memberSince});

  factory LocalAffiliate.fromJson(Map<String, dynamic> json) => LocalAffiliate(
      userId: json["userId"],
      fullName: json["fullName"],
      phone: json["phone"],
      email: json["email"],
      totalRequests: json["totalRequests"],
      acceptedRequests: json["acceptedRequests"],
      rejectedRequests: json["rejectedRequests"],
      totalMade: json["totalMade"],
      currentBalance: json["currentBalance"],
      canWithdrawAfter: json["canWithdrawAfter"],
      memberSince: json["memberSince"]);

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "fullName": fullName,
    "phone": phone,
    "email": email,
    "totalRequests": totalRequests,
    "acceptedRequests": acceptedRequests,
    "rejectedRequests": rejectedRequests,
    "totalMade": totalMade,
    "currentBalance": currentBalance,
    "canWithdrawAfter": canWithdrawAfter,
    "memberSince": memberSince
  };
}
