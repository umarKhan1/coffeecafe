import 'package:coffeecafe/features/cart/models/cart_item.dart';

abstract class ICartRepository {
  Future<List<CartItem>> load();
  Future<void> save(List<CartItem> items);
}
