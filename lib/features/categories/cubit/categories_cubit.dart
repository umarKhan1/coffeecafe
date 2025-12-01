import 'package:coffeecafe/features/categories/cubit/categories_state.dart';
import 'package:coffeecafe/features/categories/models/category_item.dart';
import 'package:coffeecafe/features/categories/repositories/i_categories_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({required ICategoriesRepository repository})
      : _repository = repository,
        super(const CategoriesState());

  final ICategoriesRepository _repository;

  Future<void> load() async {
    try {
      final cats = await _repository.getCategories();
      final firstId = cats.isNotEmpty ? cats.first.id : null;
      final List<CategoryItem> items =
          firstId != null ? await _repository.getItemsForCategory(firstId) : <CategoryItem>[];
      emit(state.copyWith(categories: cats, selectedId: firstId, items: items));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to load: $e'));
    }
  }

  Future<void> select(String categoryId) async {
    emit(state.copyWith(selectedId: categoryId));
    try {
      final items = await _repository.getItemsForCategory(categoryId);
      emit(state.copyWith(items: items));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to load items: $e'));
    }
  }
}
