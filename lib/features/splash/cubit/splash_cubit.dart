import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffeecafe/features/splash/cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial());

  Future<void> start() async {
    await Future<void>.delayed(const Duration(seconds: 4));
    emit(const SplashNavigateLogin());
  }
}
