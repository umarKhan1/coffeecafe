import 'package:coffeecafe/core/di/app_providers.dart';
import 'package:coffeecafe/core/routes/app_router.dart';
import 'package:coffeecafe/core/theme/app_theme.dart';
import 'package:coffeecafe/features/splash/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppProviders.global(),
      child: ScreenUtilInit(
        designSize: const Size(390, 844), // iPhone 12 baseline
        minTextAdapt: true,
        builder: (context, child) {
          // trigger splash start once, if available
          context.read<SplashCubit>().start();
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'CoffeeCafe',
            theme: AppTheme.dark,
            themeMode: ThemeMode.dark,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
