import 'package:equatable/equatable.dart';

class LoginValidatorState extends Equatable {
  const LoginValidatorState({
    this.phone = '',
    this.password = '',
    this.isSubmitting = false,
    this.showPassword = false,
    this.phoneError,
    this.passwordError,
  });

  final String phone;
  final String password;
  final bool isSubmitting;
  final bool showPassword;
  final String? phoneError;
  final String? passwordError;

  LoginValidatorState copyWith({
    String? phone,
    String? password,
    bool? isSubmitting,
    bool? showPassword,
    String? phoneError,
    String? passwordError,
  }) => LoginValidatorState(
        phone: phone ?? this.phone,
        password: password ?? this.password,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        showPassword: showPassword ?? this.showPassword,
        phoneError: phoneError,
        passwordError: passwordError,
      );

  @override
  List<Object?> get props => [phone, password, isSubmitting, showPassword, phoneError, passwordError];
}
