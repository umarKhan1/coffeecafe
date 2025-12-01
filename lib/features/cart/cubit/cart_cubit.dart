import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffeecafe/features/cart/cubit/cart_state.dart';
import 'package:coffeecafe/features/cart/models/cart_item.dart';
import 'package:coffeecafe/features/cart/repositories/i_cart_repository.dart';
import 'package:coffeecafe/features/product_detail/models/milk_type.dart';
import 'package:coffeecafe/features/product_detail/models/product_detail.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required ICartRepository repository})
      : _repository = repository,
        super(const CartState());

  final ICartRepository _repository;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true));
    try {
      final items = await _repository.load();
      emit(state.copyWith(isLoading: false, items: items));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Failed to load cart: $e'));
    }
  }

  Future<void> addProduct(ProductDetail product, MilkType? milk, int qty) async {
    final id = _variantId(product.id, milk);
    final existingIndex = state.items.indexWhere((e) => e.id == id);
    List<CartItem> updated = List<CartItem>.from(state.items);
    if (existingIndex >= 0) {
      final existing = updated[existingIndex];
      updated[existingIndex] = existing.copyWith(qty: existing.qty + qty);
    } else {
      updated.add(CartItem(
        id: id,
        productId: product.id,
        title: product.title,
        milk: milk,
        qty: qty,
        unitPrice: product.price,
      ));
    }
    emit(state.copyWith(items: updated));
    await _repository.save(updated);
  }

  Future<void> updateQty(String itemId, int qty) async {
    if (qty < 1) return;
    final updated = state.items.map((e) => e.id == itemId ? e.copyWith(qty: qty) : e).toList();
    emit(state.copyWith(items: updated));
    await _repository.save(updated);
  }

  Future<void> remove(String itemId) async {
    final updated = state.items.where((e) => e.id != itemId).toList();
    emit(state.copyWith(items: updated));
    await _repository.save(updated);
  }

  String _variantId(String productId, MilkType? milk) => milk == null ? productId : '${productId}_${milk.name}';
}
