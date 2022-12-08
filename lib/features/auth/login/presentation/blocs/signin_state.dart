abstract class SignInState {}

class InitialSignInState extends SignInState {}

class SignInStateSuccessful extends SignInState {}

class SignInStateLoading extends SignInState {}

class SignInStateFailed extends SignInState {
  final String errorType;
  SignInStateFailed(this.errorType);
}

class SendRecoveryEmailSuccessful extends SignInState {}

class SendRecoveryEmailLoading extends SignInState {}

class SendRecoveryEmailFailed extends SignInState {
  final String errorType;
  SendRecoveryEmailFailed(this.errorType);
}

class ResetEmailSuccessful extends SignInState {}

class ResetEmailLoading extends SignInState {}

class ResetEmailFailed extends SignInState {
  final String errorType;
  ResetEmailFailed(this.errorType);
}