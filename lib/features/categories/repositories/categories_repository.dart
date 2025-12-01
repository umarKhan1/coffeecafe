import 'package:coffeecafe/core/constants/app_assets.dart';
import 'package:coffeecafe/core/constants/app_strings.dart';
import 'package:coffeecafe/features/categories/models/category.dart';
import 'package:coffeecafe/features/categories/models/category_item.dart';
import 'package:coffeecafe/features/categories/repositories/i_categories_repository.dart';

class CategoriesRepository implements ICategoriesRepository {
  const CategoriesRepository();

  static final List<Category> _categories = [
    const Category(id: 'coffee', label: AppStrings.categoryCoffee, icon: AppAssets.coffeeIcon),
    const Category(id: 'beer', label: AppStrings.categoryBeer, icon: AppAssets.beerIcon),
    const Category(id: 'wine', label: AppStrings.categoryWineBar, icon: AppAssets.wineIcon),
    const Category(id: 'event', label: AppStrings.categoryEvent, icon: AppAssets.eventIcon),
  ];

  static final Map<String, List<CategoryItem>> _items = {
    'coffee': [
      const CategoryItem(id: 'c1', title: 'Chai Latte', price: 85.0, image: AppAssets.chai),
      const CategoryItem(id: 'c2', title: 'Matcha Latte', price: 22.0, image: AppAssets.matcha),
      const CategoryItem(id: 'c3', title: 'Red Eye Coffee', price: 60.0, image: AppAssets.redEye),
    ],
    'beer': [
      const CategoryItem(id: 'b1', title: 'Pale Ale', price: 45.0, image: AppAssets.cup),
      const CategoryItem(id: 'b2', title: 'Stout', price: 55.0, image: AppAssets.cup),
    ],
    'wine': [
      const CategoryItem(id: 'w1', title: 'Merlot', price: 120.0, image: AppAssets.cup),
      const CategoryItem(id: 'w2', title: 'Chardonnay', price: 140.0, image: AppAssets.cup),
    ],
    'event': [
      const CategoryItem(id: 'e1', title: 'Open Mic Ticket', price: 15.0, image: AppAssets.cup),
    ],
  };

  @override
  Future<List<Category>> getCategories() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return _categories;
  }

  @override
  Future<List<CategoryItem>> getItemsForCategory(String categoryId) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return _items[categoryId] ?? const [];
  }
}
