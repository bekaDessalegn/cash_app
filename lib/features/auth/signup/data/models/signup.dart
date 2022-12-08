class SignUp{
  final String fullName;
  final String phone;
  final String email;
  final String passwordHash;
  final String? parentId;

  SignUp({required this.fullName, required this.phone, required this.email, required this.passwordHash, this.parentId});
}