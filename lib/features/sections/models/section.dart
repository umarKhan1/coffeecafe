import 'package:equatable/equatable.dart';

class Section extends Equatable {
  const Section({required this.id, required this.title});
  final String id;
  final String title;
  @override
  List<Object?> get props => [id, title];
}
