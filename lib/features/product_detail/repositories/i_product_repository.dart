import 'package:coffeecafe/features/product_detail/models/product_detail.dart';

abstract class IProductRepository {
  Future<ProductDetail> getProductById(String id);
}
