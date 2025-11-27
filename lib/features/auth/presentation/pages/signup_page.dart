import 'package:coffeecafe/core/constants/app_assets.dart';
import 'package:coffeecafe/core/constants/app_colors.dart';
import 'package:coffeecafe/core/constants/app_strings.dart';
import 'package:coffeecafe/core/widgets/app_button.dart';
import 'package:coffeecafe/core/widgets/app_text_field.dart';
import 'package:coffeecafe/features/auth/cubit/login_cubit_vaildator/login_validator_cubit.dart';
import 'package:coffeecafe/features/auth/cubit/signup_validator/signup_validator_cubit.dart';
import 'package:coffeecafe/features/auth/cubit/signup_validator/signup_validator_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: BlocBuilder<SignupValidatorCubit, SignupValidatorState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30.h),
                  Center(
                    child: Column(
                      children: [
                        Image.asset(AppAssets.cup, width: 65.w, fit: BoxFit.cover),
                        SizedBox(height: 12.h),
                        Text(
                          AppStrings.coffeeTaste,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                letterSpacing: 3,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 53.h),
                  Text(
                    AppStrings.signUp,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    AppStrings.signUpSubtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: const Color(0xCCFFFFFF),
                        ),
                  ),
                  SizedBox(height: 60.h),
    
                  // Phone
                  AppTextField(
                    label: AppStrings.phoneNumber,
                    hint: AppStrings.phoneHint,
                    prefixIcon: Icons.phone_iphone,
                    keyboardType: TextInputType.phone,
                    onChanged: (v) => context.read<SignupValidatorCubit>().phoneChanged(v),
                    errorText: state.phoneError,
                  ),
                  SizedBox(height: 20.h),
    
                  // Password
                  AppTextField(
                    label: AppStrings.password,
                    hint: AppStrings.passwordHint,
                    prefixIcon: Icons.password,
                    obscureText: !state.showPassword,
                    onChanged: (v) => context.read<SignupValidatorCubit>().passwordChanged(v),
                    errorText: state.passwordError,
                    suffixIcon: state.showPassword ? Icons.visibility_off : Icons.visibility,
                    suffixOnPressed: () => context.read<SignupValidatorCubit>().togglePassword(),
                  ),
                  SizedBox(height: 20.h),
    
                  // Confirm Password
                  AppTextField(
                    label: AppStrings.rePassword,
                    hint: AppStrings.passwordHint,
                    prefixIcon: Icons.password,
                    obscureText: !state.showConfirmPassword,
                    onChanged: (v) => context.read<SignupValidatorCubit>().confirmPasswordChanged(v),
                    errorText: state.confirmPasswordError,
                    suffixIcon: state.showConfirmPassword ? Icons.visibility_off : Icons.visibility,
                    suffixOnPressed: () => context.read<SignupValidatorCubit>().toggleConfirmPassword(),
                  ),
    
                  SizedBox(height: 32.h),
                  AppButton(
                    label: AppStrings.signUp,
                    onPressed: state.isSubmitting
                        ? null
                        : () {
                            final cubit = context.read<SignupValidatorCubit>();
                            cubit.submit().then((_) {
                              final newState = cubit.state;
                              if (newState.phoneError == null &&
                                  newState.passwordError == null &&
                                  newState.confirmPasswordError == null &&
                                  !newState.isSubmitting) {
                                final messenger = ScaffoldMessenger.maybeOf(context);
                                messenger?.showSnackBar(
                                  const SnackBar(content: Text(AppStrings.signingUp)),
                                );
                              }
                            });
                          },
                  ),
    
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.alreadyHaveAccount,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          // Reset login state and go back
                          context.read<LoginValidatorCubit>().reset();
                          context.pop();
                        },
                        child: Text(
                          AppStrings.signIn,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.surface,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.surface,
                              ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
