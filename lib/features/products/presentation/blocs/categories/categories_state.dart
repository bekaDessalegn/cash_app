import 'package:cash_app/features/products/data/models/categories.dart';

abstract class CategoriesState {}

class InitialCategoriesState extends CategoriesState {}

class GetCategoriesSuccessful extends CategoriesState {
  final List<Categories> categories;
  GetCategoriesSuccessful(this.categories);
}

class GetCategoriesLoading extends CategoriesState {}

class GetCategoriesFailed extends CategoriesState {
  final String errorType;
  GetCategoriesFailed(this.errorType);
}