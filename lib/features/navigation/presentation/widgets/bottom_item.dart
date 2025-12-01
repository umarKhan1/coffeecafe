import 'package:coffeecafe/core/constants/app_colors.dart';
import 'package:coffeecafe/features/navigation/models/nav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomItem extends StatelessWidget {
  const BottomItem({super.key, required this.item, required this.selected, required this.onTap});

  final NavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
 
    return Expanded(
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Center(
            child: AnimatedScale(
              scale: selected ? 1.0 : 0.95,
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                width: 52.r,
                height: 52.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // Keep container transparent; animate inner fill to avoid layout shift
                  color: Colors.transparent,
                  boxShadow: selected
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Animated filled circle
                    AnimatedOpacity(
                      opacity: selected ? 1 : 0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.surface,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    // Icon with smooth color swap
                    Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        switchInCurve: Curves.easeOut,
                        switchOutCurve: Curves.easeOut,
                        child: Icon(
                          item.icon,
                          key: ValueKey<bool>(selected),
                          size: 24.sp,
                          color: Colors.white.withValues(alpha: 0.72),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
