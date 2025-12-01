import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffeecafe/core/constants/app_strings.dart';
import 'package:coffeecafe/core/constants/app_colors.dart';
import 'package:coffeecafe/features/sections/cubit/sections_cubit.dart';
import 'package:coffeecafe/features/sections/cubit/sections_state.dart';
import 'package:coffeecafe/features/sections/models/section_item.dart';
import 'package:coffeecafe/features/product_detail/models/product_id_mapper.dart';
import 'package:coffeecafe/features/product_detail/presentation/pages/product_detail_page.dart';

class SectionBlock extends StatelessWidget {
  const SectionBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SectionsCubit, SectionsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final s in state.sections) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      s.title,
                      style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      AppStrings.seeAll,
                      style: TextStyle(color: AppColors.accent, fontSize: 14.sp, decoration: TextDecoration.underline, decorationColor: AppColors.accent ),
                    ),
                  ],
                ),
              ),
              _SectionItemsRow(items: state.itemsById[s.id] ?? const []),
              SizedBox(height: 20.h),
            ],
          ],
        );
      },
    );
  }
}

class _SectionItemsRow extends StatelessWidget {
  const _SectionItemsRow({required this.items});
  final List<SectionItem> items;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.h,

      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, _) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () {
              final id = ProductIdMapper.fromTitle(item.title);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ProductDetailPage(productId: id)),
              );
            },
            child: Container(
              width: 230.w,
              decoration: BoxDecoration(color: AppColors.darkCard, borderRadius: BorderRadius.circular(24.r)),
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 70.h,
                          width: 70.w,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.06), shape: BoxShape.circle),
                        ),
                        Image.asset(item.image, width: 40.w, fit: BoxFit.contain),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700)),
                      SizedBox(height: 8.h),
                      Text('\$${item.price.toStringAsFixed(2)}', style: TextStyle(color: AppColors.accent, fontSize: 16.sp, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
