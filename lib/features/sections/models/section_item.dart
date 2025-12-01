import 'package:equatable/equatable.dart';

class SectionItem extends Equatable {
  const SectionItem({required this.id, required this.title, required this.price, required this.image});
  final String id;
  final String title;
  final double price;
  final String image;
  @override
  List<Object?> get props => [id, title, price, image];
}
