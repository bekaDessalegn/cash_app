import 'package:cash_app/features/products/data/models/orders.dart';

abstract class ProductsEvent {}

class GetProductsEvent extends ProductsEvent {}

class GetProductsForListEvent extends ProductsEvent {
  int skipNumber;
  GetProductsForListEvent(this.skipNumber);
}

class SearchProductsEvent extends ProductsEvent {
  String productName;
  SearchProductsEvent(this.productName);
}

class FilterProductsByCategoryEvent extends ProductsEvent {
  String categoryName;
  int skipNumber;
  FilterProductsByCategoryEvent(this.categoryName, this.skipNumber);
}

abstract class SingleProductEvent {}

class GetSingleProductEvent extends SingleProductEvent {
  String productId;
  GetSingleProductEvent(this.productId);
}

abstract class SearchEvent {}

class SearchProductEvent extends SearchEvent {
  String productName;
  SearchProductEvent(this.productName);
}

abstract class OrdersEvent {}

class PostOrdersEvent extends OrdersEvent {
  Orders orders;
  PostOrdersEvent(this.orders);
}