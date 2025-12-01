import 'package:coffeecafe/features/categories/models/category.dart';
import 'package:coffeecafe/features/categories/models/category_item.dart';

abstract class ICategoriesRepository {
  Future<List<Category>> getCategories();
  Future<List<CategoryItem>> getItemsForCategory(String categoryId);
}
