import 'package:cash_app/features/products/data/models/local_products.dart';
import 'package:cash_app/features/products/data/models/products.dart';

abstract class ProductsState {}

class InitialProductsState extends ProductsState {}

class GetProductsSuccessful extends ProductsState {
  final List<Products> products;
  GetProductsSuccessful(this.products);
}

class GetProductsLoading extends ProductsState {}

class SocketErrorState extends ProductsState {
  final List<LocalProducts> localProducts;
  SocketErrorState(this.localProducts);
}

class GetProductsFailed extends ProductsState {
  final String errorType;
  GetProductsFailed(this.errorType);
}

abstract class SingleProductState {}

class InitialGetProductState extends SingleProductState {}

class GetSingleProductSuccessful extends SingleProductState {
  final Products product;
  GetSingleProductSuccessful(this.product);
}

class GetSingleProductSocketError extends SingleProductState {}

class GetSingleProductFailed extends SingleProductState {
  final String errorType;
  GetSingleProductFailed(this.errorType);
}

class GetSingleProductLoading extends SingleProductState {}

abstract class SearchState {}

class InitialSearchProductState extends SearchState {}

class SearchProductSuccessful extends SearchState {
  final List<Products> product;
  SearchProductSuccessful(this.product);
}

class SearchProductSocketErrorState extends SearchState {
  final List<LocalProducts> localProducts;
  SearchProductSocketErrorState(this.localProducts);
}

class SearchProductFailed extends SearchState {
  final String errorType;
  SearchProductFailed(this.errorType);
}

class SearchProductLoading extends SearchState {}

abstract class OrdersState {}

class InitialPostOrdersState extends OrdersState {}

class PostOrdersSuccessfulState extends OrdersState {}

class PostOrdersLoadingState extends OrdersState {}

class PostOrdersFailedState extends OrdersState {
  final String errorType;
  PostOrdersFailedState(this.errorType);
}