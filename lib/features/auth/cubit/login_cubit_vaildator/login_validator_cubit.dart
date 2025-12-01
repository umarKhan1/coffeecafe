import 'package:coffeecafe/core/constants/app_strings.dart';
import 'package:coffeecafe/features/auth/cubit/login_cubit_vaildator/login_validator_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginValidatorCubit extends Cubit<LoginValidatorState> {
  LoginValidatorCubit() : super(const LoginValidatorState());

  // Reset to initial state
  void reset() => emit(const LoginValidatorState());
  
  void phoneChanged(String value) {
    emit(state.copyWith(phone: value, phoneError: null));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, passwordError: null));
  }

  void togglePassword() {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  bool _isValidPhone(String v) => RegExp(r'^\+?[0-9]{8,15}$').hasMatch(v.trim());

  LoginValidatorState validate() {
    String? phoneErr;
    String? passErr;
    if (state.phone.trim().isEmpty) {
      phoneErr = AppStrings.errPhoneRequired;
    } else if (!_isValidPhone(state.phone)) {
      phoneErr = AppStrings.errPhoneInvalid;
    }
    if (state.password.isEmpty) {
      passErr = AppStrings.errPasswordRequired;
    } else if (state.password.length < 6) {
      passErr = AppStrings.errPasswordMin;
    }
    final next = state.copyWith(phoneError: phoneErr, passwordError: passErr);
    emit(next);
    return next;
  }

  Future<void> submit() async {
    final validated = validate();
    if (validated.phoneError != null || validated.passwordError != null) return;
    emit(state.copyWith(isSubmitting: true));
    await Future<void>.delayed(const Duration(milliseconds: 800));
    emit(state.copyWith(isSubmitting: false));
  }
}
