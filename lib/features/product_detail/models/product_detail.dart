import 'package:equatable/equatable.dart';
import 'milk_type.dart';

class ProductDetail extends Equatable {
  const ProductDetail({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.rating,
    required this.price,
    required this.image,
    required this.availableMilks,
  });
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final double rating;
  final double price;
  final String image; // asset path or network
  final List<MilkType> availableMilks;

  @override
  List<Object?> get props => [id, title, subtitle, description, rating, price, image, availableMilks];
}
