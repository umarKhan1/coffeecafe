import 'package:coffeecafe/core/constants/app_strings.dart';
import 'package:coffeecafe/features/cart/presentation/pages/cart_page.dart';
import 'package:coffeecafe/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:coffeecafe/features/navigation/cubit/nav_cubit.dart';
import 'package:coffeecafe/features/navigation/models/nav_item.dart';
import 'package:coffeecafe/features/navigation/presentation/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavShell extends StatelessWidget {
  const NavShell({super.key});

  static final _items = <NavItem> [
   const NavItem(icon: Icons.dashboard_rounded, label: AppStrings.navHome),
   const NavItem(icon: Icons.shopping_bag_rounded, label: AppStrings.cartTitle),
   const NavItem(icon: Icons.favorite_rounded, label: AppStrings.navFavorites),
   const NavItem(icon: Icons.receipt_long_rounded, label: AppStrings.navOrders),
   const NavItem(icon: Icons.person_rounded, label: AppStrings.navProfile),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, NavState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          backgroundColor: Theme.of(context).primaryColor,
          body: _buildBody(state.index),
          bottomNavigationBar: BottomBar(
            items: _items,
            currentIndex: state.index,
            onTap: context.read<NavCubit>().setIndex,
          ),
        );
      },
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return const DashboardPage();
      case 1:
        return const CartPage();
      case 2:
        return const Center(child: Text(AppStrings.navFavorites, style: TextStyle(color: Colors.white)));
      case 3:
        return const Center(child: Text(AppStrings.navOrders, style: TextStyle(color: Colors.white)));
      case 4:
        return const Center(child: Text(AppStrings.navProfile, style: TextStyle(color: Colors.white)));
      default:
        return const SizedBox();
    }
  }
}
