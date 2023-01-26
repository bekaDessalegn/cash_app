import 'dart:io';

import 'package:cash_app/features/products/data/repositories/products_repositories.dart';
import 'package:cash_app/features/products/presentation/blocs/products/products_event.dart';
import 'package:cash_app/features/products/presentation/blocs/products/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsRepository productsRepository;
  ProductsBloc(this.productsRepository) : super(InitialProductsState()){
    on<GetProductsEvent>(_onGetProductsEvent);
    on<GetProductsForListEvent>(_onGetProductsForListEvent);
    on<FilterProductsByCategoryEvent>(_onFilterProductsByCategoryEvent);
  }

  void _onGetProductsEvent(GetProductsEvent event, Emitter emit) async {
    // emit(GetProductsLoading());
    // await yed(Duration(seconds: 2));
    try {
      final products = await productsRepository.getProducts();
      emit(GetProductsSuccessful(products));
    } on SocketException{
      emit(GetProductsFailed("Something went wrong please, try again"));
    } on Exception{
      emit(GetProductsFailed("Something went wrong please, try again"));
    }
  }

  void _onGetProductsForListEvent(GetProductsForListEvent event, Emitter emit) async {
    emit(GetProductsLoading());
    try {
      final products = await productsRepository.getProductsForList(event.skipNumber);
      if(products.runtimeType.toString() == "List<LocalProducts>"){
        emit(SocketErrorState(products));
      } else{
        emit(GetProductsSuccessful(products));
      }
    } on SocketException{
      emit(GetProductsFailed("Something went wrong please, try again"));
    } on Exception{
      emit(GetProductsFailed("Something went wrong please, try again"));
    }
  }

  void _onFilterProductsByCategoryEvent(FilterProductsByCategoryEvent event, Emitter emit) async {
    emit(GetProductsLoading());
    try {
      final products = await productsRepository.filterProductsByCategory(event.categoryName, event.skipNumber);
      emit(GetProductsSuccessful(products));
    } on SocketException{
      emit(GetProductsFailed("Something went wrong please, try again"));
    } on Exception{
      emit(GetProductsFailed("Something went wrong please, try again"));
    }
  }

}

class SingleProductBloc extends Bloc<SingleProductEvent, SingleProductState>{
  ProductsRepository productsRepository;
  SingleProductBloc(this.productsRepository) : super(InitialGetProductState()){
    on<GetSingleProductEvent>(_onGetSingleProductEvent);
  }

  void _onGetSingleProductEvent(GetSingleProductEvent event, Emitter emit) async {
    emit(GetSingleProductLoading());
    try {
      final product = await productsRepository.getProduct(event.productId);
      if(product == "Socket Error"){
        emit(GetSingleProductSocketError());
      } else{
        emit(GetSingleProductSuccessful(product));
      }
    } on SocketException{
      emit(GetSingleProductFailed("Something went wrong please, try again"));
    } on Exception{
      emit(GetSingleProductFailed("Something went wrong please, try again"));
    }
  }

}

class SearchProductBloc extends Bloc<SearchEvent, SearchState>{
  ProductsRepository productsRepository;
  SearchProductBloc(this.productsRepository) : super(InitialSearchProductState()){
    on<SearchProductEvent>(_onSearchProductEvent);
  }

  void _onSearchProductEvent(SearchProductEvent event, Emitter emit) async {
    emit(SearchProductLoading());
    try {
      final products = await productsRepository.searchProducts(event.productName);
      if(products.runtimeType.toString() == "List<LocalProducts>"){
        emit(SearchProductSocketErrorState(products));
      } else{
        emit(SearchProductSuccessful(products));
      }
    } on SocketException{
      emit(SearchProductFailed("Something went wrong please, try again"));
    } on Exception{
      emit(SearchProductFailed("Something went wrong please, try again"));
    }
  }

}

class OrdersBloc extends Bloc<OrdersEvent, OrdersState>{
  ProductsRepository productsRepository;
  OrdersBloc(this.productsRepository) : super(InitialPostOrdersState()){
    on<PostOrdersEvent>(_onPostOrdersEvent);
  }

  void _onPostOrdersEvent(PostOrdersEvent event, Emitter emit) async {
    emit(PostOrdersLoadingState());
    try{
      await productsRepository.postOrders(event.orders);
      emit(PostOrdersSuccessfulState());
    } catch(e) {
      emit(PostOrdersFailedState("Something went wrong"));
    }
  }
}

