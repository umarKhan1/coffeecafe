import 'package:coffeecafe/features/categories/cubit/categories_cubit.dart';
import 'package:coffeecafe/features/categories/cubit/categories_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryChipList extends StatelessWidget {
  const CategoryChipList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      buildWhen: (p, c) => p.categories != c.categories || p.selectedId != c.selectedId,
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: state.categories
                .map((cat) => Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: _CategoryChip(
                        isSelected: state.selectedId == cat.id,
                        label: cat.label,
                        icon: cat.icon,
                        onTap: () => context.read<CategoriesCubit>().select(cat.id),
                      ),
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.isSelected,
    required this.label,
    required this.icon,
    required this.onTap,
  });
  final bool isSelected;
  final String label;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFB68A53) : Colors.transparent,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
        ),
        child: Row(
          children: [
            Image.asset(icon, width: 20.w, height: 20.w, fit: BoxFit.fill,),
            SizedBox(width: 10.w),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
