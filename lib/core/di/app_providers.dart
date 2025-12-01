import 'package:coffeecafe/features/auth/cubit/login_cubit_vaildator/login_validator_cubit.dart';
import 'package:coffeecafe/features/auth/cubit/signup_validator/signup_validator_cubit.dart';
import 'package:coffeecafe/features/categories/cubit/categories_cubit.dart';
import 'package:coffeecafe/features/categories/repositories/categories_repository.dart';
import 'package:coffeecafe/features/navigation/cubit/nav_cubit.dart';
import 'package:coffeecafe/features/search/cubit/search_cubit.dart';
import 'package:coffeecafe/features/splash/cubit/splash_cubit.dart';
import 'package:coffeecafe/features/sections/cubit/sections_cubit.dart';
import 'package:coffeecafe/features/sections/repositories/sections_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/cart/cubit/cart_cubit.dart';
import '../../features/cart/repositories/cart_repository.dart';

class AppProviders {
  const AppProviders._();

  static List<BlocProvider> global() => <BlocProvider>[
        BlocProvider<SplashCubit>(create: (_) => SplashCubit()),
        BlocProvider<LoginValidatorCubit>(create: (_) => LoginValidatorCubit()),
        BlocProvider<SignupValidatorCubit>(create: (_) => SignupValidatorCubit()),
        BlocProvider<NavCubit>(create: (_) => NavCubit()),
        BlocProvider<SearchCubit>(create: (_) => SearchCubit()),
        BlocProvider<CategoriesCubit>(create: (_) => CategoriesCubit(repository: const CategoriesRepository())..load()),
        BlocProvider<SectionsCubit>(create: (_) => SectionsCubit(repository: const SectionsRepository())..load()),
        BlocProvider<CartCubit>(create: (_) => CartCubit(repository: CartRepository())..load()),
      ];
}
