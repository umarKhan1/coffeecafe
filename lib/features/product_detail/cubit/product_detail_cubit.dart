import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffeecafe/features/product_detail/repositories/i_product_repository.dart';
import 'package:coffeecafe/features/product_detail/cubit/product_detail_state.dart';
import 'package:coffeecafe/features/product_detail/models/milk_type.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit({required IProductRepository repository})
      : _repository = repository,
        super(const ProductDetailState());

  final IProductRepository _repository;

  Future<void> load(String id) async {
    emit(state.copyWith(isLoading: true));
    try {
      final product = await _repository.getProductById(id);
      emit(state.copyWith(isLoading: false, product: product));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Failed to load product: $e'));
    }
  }

  void selectMilk(MilkType milk) => emit(state.copyWith(selectedMilk: milk));
  void toggleExpanded() => emit(state.copyWith(expanded: !state.expanded));
  void incrementQty() => emit(state.copyWith(qty: state.qty + 1));
  void decrementQty() {
    if (state.qty > 1) emit(state.copyWith(qty: state.qty - 1));
  }
}
