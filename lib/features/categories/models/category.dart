import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({required this.id, required this.label, required this.icon});
  final String id;
  final String label;
  final String icon; // asset path
  @override
  List<Object?> get props => [id, label, icon];
}
