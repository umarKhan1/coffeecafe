import 'package:coffeecafe/features/product_detail/models/milk_type.dart';
import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  const CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.milk,
    required this.qty,
    required this.unitPrice,
  });

  final String id; // unique per variant (product + milk)
  final String productId;
  final String title;
  final MilkType? milk; // nullable when product has no milk option
  final int qty;
  final double unitPrice;

  double get totalPrice => unitPrice * qty;

  CartItem copyWith({int? qty}) => CartItem(
        id: id,
        productId: productId,
        title: title,
        milk: milk,
        qty: qty ?? this.qty,
        unitPrice: unitPrice,
      );

  @override
  List<Object?> get props => [id, productId, title, milk, qty, unitPrice];
}
