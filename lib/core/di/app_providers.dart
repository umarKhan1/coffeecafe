import 'package:coffeecafe/features/splash/presentation/bloc/splash_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppProviders {
  const AppProviders._();

  static List<BlocProvider> global() => <BlocProvider>[
        BlocProvider<SplashCubit>(create: (_) => SplashCubit()),
      ];
}
