import 'dart:io';

import 'package:cash_app/features/home/data/repositories/home_repository.dart';
import 'package:cash_app/features/home/presentation/blocs/home_event.dart';
import 'package:cash_app/features/home/presentation/blocs/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewInStoreBloc extends Bloc<NewInStoreEvent, NewInStoreState> {
  HomeRepository homeRepository;
  NewInStoreBloc(this.homeRepository) : super(InitialHomeState()){
    on<NewInStoreProductsEvent>(_onNewInStoreProductsEvent);
  }

  void _onNewInStoreProductsEvent(NewInStoreProductsEvent event, Emitter emit) async {
    emit(NewInStoreLoading());
    try {
      final products = await homeRepository.newInStoreProducts();
      if(products.runtimeType.toString() == "List<LocalProducts>"){
        emit(NewInStoreSocketError(products));
      } else{
        emit(NewInStoreSuccessful(products));
      }
    } on SocketException{
      emit(NewInStoreFailed("Something went wrong please, try again"));
    } on Exception{
      emit(NewInStoreFailed("Something went wrong please, try again"));
    }
  }

}

class FeaturedBloc extends Bloc<FeaturedEvent, FeaturedState> {
  HomeRepository homeRepository;
  FeaturedBloc(this.homeRepository) : super(InitialFeaturedState()){
    on<FilterFeaturedEvent>(_onFilterFeaturedEvent);
  }

  void _onFilterFeaturedEvent(FilterFeaturedEvent event, Emitter emit) async {
    emit(FilterFeatureStateLoading());
    try {
      final products = await homeRepository.filterFetauredProducts();
      if(products.runtimeType.toString() == "List<LocalProducts>"){
        emit(FeaturedSocketErrorState(products));
      } else{
        emit(FilterFeatureStateSuccessful(products));
      }
    } on SocketException{
      emit(FilterFeatureStateFailed("Something went wrong please, try again"));
    } on Exception{
      emit(FilterFeatureStateFailed("Something went wrong please, try again"));
    }
  }

}

class TopSellerBloc extends Bloc<TopSellerEvent, TopSellerState> {
  HomeRepository homeRepository;
  TopSellerBloc(this.homeRepository) : super(InitialTopSellerState()){
    on<FilterTopSellerEvent>(_onFilterTopSellerEvent);
  }

  void _onFilterTopSellerEvent(FilterTopSellerEvent event, Emitter emit) async {
    emit(FilterTopSellerStateLoading());
    try {
      final products = await homeRepository.filterTopSellerProducts();
      if(products.runtimeType.toString() == "List<LocalProducts>"){
        emit(TopSellerSocketErrorState(products));
      } else{
        emit(FilterTopSellerStateSuccessful(products));
      }
    } on SocketException{
      emit(FilterTopSellerStateFailed("Something went wrong please, try again"));
    } on Exception{
      emit(FilterTopSellerStateFailed("Something went wrong please, try again"));
    }
  }

}

class HomeContentBloc extends Bloc<HomeContentEvent, HomeContentState> {
  HomeRepository homeRepository;
  HomeContentBloc(this.homeRepository) : super(InitialHomeContentState()){
    on<GetHomeContentEvent>(_onGetHomeContentEvent);
  }

  void _onGetHomeContentEvent(GetHomeContentEvent event, Emitter emit) async {
    emit(GetHomeContentLoadingState());
    try {
      final homeContent = await homeRepository.getHomeContent();
      emit(GetHomeContentSuccessfulState(homeContent));
    } catch(e){
      emit(GetHomeContentFailedState("Something went wrong fetching the home content"));
    }
  }

}

class LogoImageBloc extends Bloc<LogoImageEvent, LogoImageState> {
  HomeRepository homeRepository;
  LogoImageBloc(this.homeRepository) : super(InitialLogoImageState()){
    on<GetLogoImageEvent>(_onGetLogoImageEvent);
  }

  void _onGetLogoImageEvent(GetLogoImageEvent event, Emitter emit) async {
    emit(GetLogoImageLoadingState());
    try {
      final logoImage = await homeRepository.getLogoImage();
      emit(GetLogoImageSuccessfulState(logoImage));
    } catch(e){
      emit(GetLogoImageFailedState("Something went wrong fetching the home content"));
    }
  }

}

class FooterBloc extends Bloc<FooterEvent, FooterState> {
  HomeRepository homeRepository;
  FooterBloc(this.homeRepository) : super(InitialFooterState()){
    on<GetFooterEvent>(_onGetFooterEvent);
  }

  void _onGetFooterEvent(GetFooterEvent event, Emitter emit) async {
    emit(GetFooterLoadingState());
    try {
      final socialLinks = await homeRepository.getFooter();
      emit(GetFooterSuccessfulState(socialLinks));
    } catch(e){
      emit(GetFooterFailedState("Something went wrong fetching the home content"));
    }
  }

}