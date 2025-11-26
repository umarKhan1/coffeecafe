import 'package:coffeecafe/features/auth/presentation/pages/login_page.dart';
import 'package:coffeecafe/features/splash/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  const AppRoutes._();

  static const splash = '/';
  static const login = '/login';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.splash,
      pageBuilder: (context, state) => const MaterialPage(child: SplashPage()),
    ),
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (context, state) => const MaterialPage(child: LoginPage()),
    ),
  ],
);
