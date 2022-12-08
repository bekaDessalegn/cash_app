class Orders{
  final String productId;
  final String fullName;
  final String phone;
  final String? companyName;
  final String? userId;

  Orders({required this.productId, required this.fullName, required this.phone, this.companyName, this.userId});
}