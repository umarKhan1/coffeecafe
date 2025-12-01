import 'package:coffeecafe/core/constants/app_strings.dart';
import 'package:coffeecafe/features/auth/cubit/signup_validator/signup_validator_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupValidatorCubit extends Cubit<SignupValidatorState> {
  SignupValidatorCubit() : super(const SignupValidatorState());

  // Reset to initial state
  void reset() => emit(const SignupValidatorState());

  void phoneChanged(String value) {
    emit(state.copyWith(phone: value, phoneError: null));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, passwordError: null));
  }

  void confirmPasswordChanged(String value) {
    emit(state.copyWith(confirmPassword: value, confirmPasswordError: null));
  }

  void togglePassword() {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  void toggleConfirmPassword() {
    emit(state.copyWith(showConfirmPassword: !state.showConfirmPassword));
  }

  bool _isValidPhone(String v) => RegExp(r'^\+?[0-9]{8,15}$').hasMatch(v.trim());

  SignupValidatorState validate() {
    String? phoneErr;
    String? passErr;
    String? confirmErr;

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

    if (state.confirmPassword.isEmpty) {
      confirmErr = AppStrings.errPasswordRequired;
    } else if (state.confirmPassword != state.password) {
      confirmErr = AppStrings.errPasswordMismatch;
    }

    final next = state.copyWith(
      phoneError: phoneErr,
      passwordError: passErr,
      confirmPasswordError: confirmErr,
    );
    emit(next);
    return next;
  }

  Future<void> submit() async {
    final validated = validate();
    if (validated.phoneError != null ||
        validated.passwordError != null ||
        validated.confirmPasswordError != null) {
      return;
    }

    emit(state.copyWith(isSubmitting: true));
    await Future<void>.delayed(const Duration(milliseconds: 800));
    emit(state.copyWith(isSubmitting: false));
  }
}
