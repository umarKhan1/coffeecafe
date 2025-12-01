import 'package:equatable/equatable.dart';
import 'package:coffeecafe/features/cart/models/cart_item.dart';

class CartState extends Equatable {
  const CartState({
    this.isLoading = false,
    this.items = const [],
    this.error,
  });

  final bool isLoading;
  final List<CartItem> items;
  final String? error;

  double get total => items.fold(0, (sum, e) => sum + e.totalPrice);
  int get count => items.fold(0, (sum, e) => sum + e.qty);

  CartState copyWith({bool? isLoading, List<CartItem>? items, String? error}) => CartState(
        isLoading: isLoading ?? this.isLoading,
        items: items ?? this.items,
        error: error,
      );

  @override
  List<Object?> get props => [isLoading, items, error];
}
