abstract class ContactUsState {}

class InitialContactUsState extends ContactUsState {}

class PostContactUsSuccessful extends ContactUsState {}

class PostContactUsLoading extends ContactUsState {}

class PostContactUsFailed extends ContactUsState {
  final String errorType;
  PostContactUsFailed(this.errorType);
}