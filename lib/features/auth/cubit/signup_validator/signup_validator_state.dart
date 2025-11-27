import 'package:equatable/equatable.dart';

class SignupValidatorState extends Equatable {
  const SignupValidatorState({
    this.phone = '',
    this.password = '',
    this.confirmPassword = '',
    this.isSubmitting = false,
    this.showPassword = false,
    this.showConfirmPassword = false,
    this.phoneError,
    this.passwordError,
    this.confirmPasswordError,
  });

  final String phone;
  final String password;
  final String confirmPassword;
  final bool isSubmitting;
  final bool showPassword;
  final bool showConfirmPassword;
  final String? phoneError;
  final String? passwordError;
  final String? confirmPasswordError;

  SignupValidatorState copyWith({
    String? phone,
    String? password,
    String? confirmPassword,
    bool? isSubmitting,
    bool? showPassword,
    bool? showConfirmPassword,
    String? phoneError,
    String? passwordError,
    String? confirmPasswordError,
  }) => SignupValidatorState(
        phone: phone ?? this.phone,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        showPassword: showPassword ?? this.showPassword,
        showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
        phoneError: phoneError,
        passwordError: passwordError,
        confirmPasswordError: confirmPasswordError,
      );

  @override
  List<Object?> get props => [
        phone,
        password,
        confirmPassword,
        isSubmitting,
        showPassword,
        showConfirmPassword,
        phoneError,
        passwordError,
        confirmPasswordError,
      ];
}
