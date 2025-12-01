import 'package:coffeecafe/features/categories/presentation/widgets/category_chip_list.dart';
import 'package:coffeecafe/features/categories/presentation/widgets/category_items_horizontal.dart';
import 'package:coffeecafe/features/dashboard/presentation/widgets/dashboard_top_hero.dart';
import 'package:coffeecafe/features/search/presentation/widgets/search_bar_widget.dart';
import 'package:coffeecafe/features/sections/presentation/widgets/section_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DashboardTopHero(),
          SizedBox(height: 20.h),
          const SearchBarWidget(),
          SizedBox(height: 20.h),
          const CategoryChipList(),
          SizedBox(height: 20.h),
          const CategoryItemsHorizontal(),
          SizedBox(height: 24.h),
          const SectionBlock(),
          // More dashboard features will be added here
        ],
      ),
    );
  }
}
