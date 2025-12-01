import 'package:equatable/equatable.dart';
import 'package:coffeecafe/features/categories/models/category.dart';
import 'package:coffeecafe/features/categories/models/category_item.dart';

class CategoriesState extends Equatable {
  const CategoriesState({
    this.categories = const [],
    this.selectedId,
    this.items = const [],
    this.error,
  });

  final List<Category> categories;
  final String? selectedId;
  final List<CategoryItem> items;
  final String? error;

  CategoriesState copyWith({
    List<Category>? categories,
    String? selectedId,
    List<CategoryItem>? items,
    String? error,
  }) => CategoriesState(
        categories: categories ?? this.categories,
        selectedId: selectedId ?? this.selectedId,
        items: items ?? this.items,
        error: error,
      );

  @override
  List<Object?> get props => [categories, selectedId, items, error];
}
