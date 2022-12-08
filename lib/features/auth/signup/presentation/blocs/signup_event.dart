import 'package:cash_app/features/auth/signup/data/models/signup.dart';

abstract class SignUpEvent {}

class InitialSignUpEvent extends SignUpEvent {}

class PostSignUpEvent extends SignUpEvent {
  SignUp signUp;
  PostSignUpEvent(this.signUp);
}

class VerifySignUpEvent extends SignUpEvent {
  String verificationCode;
  VerifySignUpEvent(this.verificationCode);
}
