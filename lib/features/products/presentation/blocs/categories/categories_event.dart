abstract class CategoriesEvent {}

class GetCategoriesEvent extends CategoriesEvent {}

class DeleteCategoryEvent extends CategoriesEvent {
  final String? categoryId;
  DeleteCategoryEvent(this.categoryId);
}