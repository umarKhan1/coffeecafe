import 'package:coffeecafe/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffeecafe/core/constants/app_strings.dart';
import 'package:coffeecafe/features/product_detail/models/milk_type.dart';

class DetailMilkSelector extends StatelessWidget {
  const DetailMilkSelector({super.key, required this.available, required this.selected, required this.onSelect});
  final List<MilkType> available;
  final MilkType? selected;
  final ValueChanged<MilkType> onSelect;

  String _label(MilkType t) {
    switch (t) {
      case MilkType.oat:
        return AppStrings.milkOat;
      case MilkType.soy:
        return AppStrings.milkSoy;
      case MilkType.almond:
        return AppStrings.milkAlmond;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.choiceOfMilk, style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w600)),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 7.w,
          runSpacing: 14.h,
          children: available.map((m) {
            final isSel = selected == m;
            return GestureDetector(
              onTap: () => onSelect(m),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSel ? AppColors.accent : Colors.transparent,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: Colors.white.withValues(alpha: isSel ? 0.0 : 0.6), width: 1.2),
                ),
                child: Text(
                  _label(m),
                  style: TextStyle(
                    color: isSel ? Colors.black : Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
