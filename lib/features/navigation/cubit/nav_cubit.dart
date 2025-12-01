import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'nav_state.dart';

class NavCubit extends Cubit<NavState> {
  NavCubit() : super(const NavState(index: 0));

  void setIndex(int i) => emit(state.copyWith(index: i));
}
