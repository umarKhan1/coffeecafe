import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffeecafe/features/navigation/presentation/pages/bottomnavigation.dart';
import 'package:coffeecafe/features/navigation/cubit/nav_cubit.dart';

class AppRouter {
  AppRouter._();

  static GoRouter create() => GoRouter(
        routes: [
          // Single-shell route; tab switching is driven by NavCubit
          GoRoute(
            path: '/',
            builder: (context, state) => const NavShell(),
          ),
        ],
        // Example: sync tab via query arg 'tab'
        redirect: (context, state) {
          final tab = state.uri.queryParameters['tab'];
          if (tab != null) {
            final i = int.tryParse(tab);
            if (i != null) context.read<NavCubit>().setIndex(i);
          }
          return null;
        },
      );
}
