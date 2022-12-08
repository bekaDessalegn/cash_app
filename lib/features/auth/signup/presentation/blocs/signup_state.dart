abstract class SignUpState {}

class InitialSignUpState extends SignUpState {}

class SignUpStateSuccessful extends SignUpState {}

class SignUpStateLoading extends SignUpState {}

class SignUpStateFailed extends SignUpState {
  final String errorType;
  SignUpStateFailed(this.errorType);
}

class VerifySignUpStateSuccessful extends SignUpState {}

class VerifySignUpStateLoading extends SignUpState {}

class VerifySignUpStateFailed extends SignUpState {
  final String errorType;
  VerifySignUpStateFailed(this.errorType);
}