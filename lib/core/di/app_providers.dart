import 'package:coffeecafe/features/auth/cubit/login_cubit_vaildator/login_validator_cubit.dart';
import 'package:coffeecafe/features/auth/cubit/signup_validator/signup_validator_cubit.dart';
import 'package:coffeecafe/features/splash/cubit/splash_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppProviders {
  const AppProviders._();

  static List<BlocProvider> global() => <BlocProvider>[
        BlocProvider<SplashCubit>(create: (_) => SplashCubit()),
        BlocProvider<LoginValidatorCubit>(create: (_) => LoginValidatorCubit()),
        BlocProvider<SignupValidatorCubit>(create: (_) => SignupValidatorCubit()),
      ];
}
