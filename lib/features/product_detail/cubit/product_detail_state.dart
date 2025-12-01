import 'package:equatable/equatable.dart';
import 'package:coffeecafe/features/product_detail/models/product_detail.dart';
import 'package:coffeecafe/features/product_detail/models/milk_type.dart';

class ProductDetailState extends Equatable {
  const ProductDetailState({
    this.isLoading = true,
    this.product,
    this.selectedMilk,
    this.qty = 1,
    this.expanded = false,
    this.error,
  });

  final bool isLoading;
  final ProductDetail? product;
  final MilkType? selectedMilk;
  final int qty;
  final bool expanded;
  final String? error;

  ProductDetailState copyWith({
    bool? isLoading,
    ProductDetail? product,
    MilkType? selectedMilk,
    int? qty,
    bool? expanded,
    String? error,
  }) => ProductDetailState(
        isLoading: isLoading ?? this.isLoading,
        product: product ?? this.product,
        selectedMilk: selectedMilk ?? this.selectedMilk,
        qty: qty ?? this.qty,
        expanded: expanded ?? this.expanded,
        error: error,
      );

  @override
  List<Object?> get props => [isLoading, product, selectedMilk, qty, expanded, error];
}
