import 'package:cash_app/features/about_us/data/models/about_content.dart';
import 'package:cash_app/features/about_us/data/models/local_about_us.dart';

abstract class AboutUsContentState {}

class InitialAboutUsContentState extends AboutUsContentState {}

class GetAboutUsContentSuccessfulState extends AboutUsContentState {
  AboutUsContent aboutUsContent;
  GetAboutUsContentSuccessfulState(this.aboutUsContent);
}

class GetAboutUsContentSocketErrorState extends AboutUsContentState {
  LocalAboutUsContent aboutUsContent;
  GetAboutUsContentSocketErrorState(this.aboutUsContent);
}

class GetAboutUsContentLoadingState extends AboutUsContentState {}

class GetAboutUsContentFailedState extends AboutUsContentState {
  String errorType;
  GetAboutUsContentFailedState(this.errorType);
}