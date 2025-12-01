import 'dart:collection';
import 'package:coffeecafe/features/cart/models/cart_item.dart';
import 'package:coffeecafe/features/cart/repositories/i_cart_repository.dart';

class CartRepository implements ICartRepository {
  CartRepository();

  final List<CartItem> _memory = [];

  @override
  Future<List<CartItem>> load() async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return UnmodifiableListView(_memory);
  }

  @override
  Future<void> save(List<CartItem> items) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    _memory
      ..clear()
      ..addAll(items);
  }
}
