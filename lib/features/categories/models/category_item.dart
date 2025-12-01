import 'package:equatable/equatable.dart';

class CategoryItem extends Equatable {
  const CategoryItem({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });
  final String id;
  final String title;
  final double price;
  final String image; // asset path
  @override
  List<Object?> get props => [id, title, price, image];
}
