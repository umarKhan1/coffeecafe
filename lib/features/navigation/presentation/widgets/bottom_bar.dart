import 'dart:ui';

import 'package:coffeecafe/core/constants/app_colors.dart';
import 'package:coffeecafe/features/navigation/models/nav_item.dart';
import 'package:coffeecafe/features/navigation/presentation/widgets/bottom_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<NavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(18.r);

    return SizedBox(                    // fixed bar height
      height: 72.h,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX:5, sigmaY: 5),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),

              
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; i < items.length; i++)
                  BottomItem(
                    item: items[i],
                    selected: i == currentIndex,
                    onTap: () => onTap(i),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
