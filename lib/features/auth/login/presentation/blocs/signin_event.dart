import 'package:cash_app/features/auth/login/data/models/signin.dart';

abstract class SignInEvent {}

class PostSignInEvent extends SignInEvent {
  SignIn signIn;
  PostSignInEvent(this.signIn);
}

class SendRecoveryEmailEvent extends SignInEvent{
  final String email;
  SendRecoveryEmailEvent(this.email);
}

class InitialSendRecoveryEvent extends SignInEvent {}

class ResetEmailEvent extends SignInEvent{
  final String recoveryToken, newPasswordHash;
  ResetEmailEvent(this.recoveryToken, this.newPasswordHash);
}

class AdminResetEmailEvent extends SignInEvent{
  final String recoveryToken, newHashPassword;
  AdminResetEmailEvent(this.recoveryToken, this.newHashPassword);
}