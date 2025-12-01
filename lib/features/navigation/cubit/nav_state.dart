part of 'nav_cubit.dart';

class NavState extends Equatable {
  const NavState({required this.index});

  final int index;

  NavState copyWith({int? index}) => NavState(index: index ?? this.index);

  @override
  List<Object?> get props => [index];
}
