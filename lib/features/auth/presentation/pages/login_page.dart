// ignore_for_file: use_build_context_synchronously

import 'package:coffeecafe/core/constants/app_assets.dart';
import 'package:coffeecafe/core/constants/app_colors.dart';
import 'package:coffeecafe/core/constants/app_strings.dart';
import 'package:coffeecafe/core/routes/app_router.dart';
import 'package:coffeecafe/core/widgets/app_button.dart';
import 'package:coffeecafe/core/widgets/app_text_field.dart';
import 'package:coffeecafe/features/auth/cubit/login_cubit_vaildator/login_validator_cubit.dart';
import 'package:coffeecafe/features/auth/cubit/login_cubit_vaildator/login_validator_state.dart';
import 'package:coffeecafe/features/auth/cubit/signup_validator/signup_validator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: BlocBuilder<LoginValidatorCubit, LoginValidatorState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50.h),
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          AppAssets.cup,
                          width: 65.w,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          AppStrings.coffeeTaste,
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge?.copyWith(letterSpacing: 3),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 53.h),
                  Text(
                    AppStrings.signIn,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    AppStrings.signInSubtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color(0xCCFFFFFF),
                    ),
                  ),
                  SizedBox(height: 80.h),
                  AppTextField(
                    label: AppStrings.phoneNumber,
                    hint: AppStrings.phoneHint,
                    prefixIcon: Icons.phone_iphone,
                    keyboardType: TextInputType.phone,
                    onChanged: (v) =>
                        context.read<LoginValidatorCubit>().phoneChanged(v),
                    errorText: state.phoneError,
                  ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    label: AppStrings.password,
                    hint: AppStrings.passwordHint,
                    prefixIcon: Icons.password,
                    obscureText: !state.showPassword,
                    onChanged: (v) =>
                        context.read<LoginValidatorCubit>().passwordChanged(v),
                    errorText: state.passwordError,
                    suffixIcon: state.showPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    suffixOnPressed: () =>
                        context.read<LoginValidatorCubit>().togglePassword(),
                  ),
                  SizedBox(height: 18.h),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppStrings.forgotPassword,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.surface,
                        fontWeight: FontWeight.w800,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.surface,
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h),
                  AppButton(
                    label: AppStrings.signIn,
                    onPressed: state.isSubmitting
                        ? null
                        : () {
                            final cubit = context.read<LoginValidatorCubit>();
                            cubit.submit().then((_) {
                              final newState = cubit.state;
                              if (newState.phoneError == null &&
                                  newState.passwordError == null &&
                                  !newState.isSubmitting) {
                                // Navigate to dashboard shell after successful sign in
                                context.pushReplacement(AppRoutes.dashboard);
                              }
                            });
                          },
                  ),
                  SizedBox(height: 33.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.dontHaveAccount,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          // Ensure signup form is fresh when navigating
                          context.read<SignupValidatorCubit>().reset();
                          context.push(AppRoutes.signup);
                        },
                        child: Text(
                          AppStrings.signUp,
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
