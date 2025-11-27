import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffeecafe/core/di/app_providers.dart';
import 'package:coffeecafe/core/routes/app_router.dart';

class CoffeeCafeApp extends StatelessWidget {
  const CoffeeCafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppProviders.global(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
