import 'package:cash_app/features/home/data/models/home_content.dart';
import 'package:cash_app/features/home/data/models/logo_image.dart';
import 'package:cash_app/features/home/data/models/social_links.dart';
import 'package:cash_app/features/home/data/models/video_links.dart';
import 'package:cash_app/features/products/data/models/products.dart';

abstract class NewInStoreState {}

class InitialHomeState extends NewInStoreState {}

class NewInStoreSuccessful extends NewInStoreState {
  final List<Products> products;
  NewInStoreSuccessful(this.products);
}

class NewInStoreLoading extends NewInStoreState {}

class NewInStoreFailed extends NewInStoreState {
  final String errorType;
  NewInStoreFailed(this.errorType);
}

abstract class FeaturedState {}

class InitialFeaturedState extends FeaturedState {}

class FilterFeatureStateSuccessful extends FeaturedState {
  final List<Products> products;
  FilterFeatureStateSuccessful(this.products);
}

class FilterFeatureStateLoading extends FeaturedState {}

class FilterFeatureStateFailed extends FeaturedState {
  final String errorType;
  FilterFeatureStateFailed(this.errorType);
}

abstract class TopSellerState {}

class InitialTopSellerState extends TopSellerState {}

class FilterTopSellerStateSuccessful extends TopSellerState {
  final List<Products> products;
  FilterTopSellerStateSuccessful(this.products);
}

class FilterTopSellerStateLoading extends TopSellerState {}

class FilterTopSellerStateFailed extends TopSellerState {
  final String errorType;
  FilterTopSellerStateFailed(this.errorType);
}

abstract class HomeContentState {}

class InitialHomeContentState extends HomeContentState {}

class GetHomeContentSuccessfulState extends HomeContentState {
  HomeContent homeContent;
  GetHomeContentSuccessfulState(this.homeContent);
}

class GetHomeContentLoadingState extends HomeContentState {}

class GetHomeContentFailedState extends HomeContentState {
  String errorType;
  GetHomeContentFailedState(this.errorType);
}

abstract class LogoImageState {}

class InitialLogoImageState extends LogoImageState {}

class GetLogoImageSuccessfulState extends LogoImageState {
  LogoImage logoImage;
  GetLogoImageSuccessfulState(this.logoImage);
}

class GetLogoImageLoadingState extends LogoImageState {}

class GetLogoImageFailedState extends LogoImageState {
  String errorType;
  GetLogoImageFailedState(this.errorType);
}

abstract class FooterState {}

class InitialFooterState extends FooterState {}

class GetFooterSuccessfulState extends FooterState {
  List<SocialLinks> socialLinks;
  GetFooterSuccessfulState(this.socialLinks);
}

class GetFooterLoadingState extends FooterState {}

class GetFooterFailedState extends FooterState {
  String errorType;
  GetFooterFailedState(this.errorType);
}
