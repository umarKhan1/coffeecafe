import 'package:coffeecafe/core/constants/app_colors.dart';
import 'package:coffeecafe/features/categories/cubit/categories_cubit.dart';
import 'package:coffeecafe/features/categories/cubit/categories_state.dart';
import 'package:coffeecafe/features/categories/models/category_item.dart';
import 'package:coffeecafe/features/product_detail/models/product_id_mapper.dart';
import 'package:coffeecafe/features/product_detail/presentation/pages/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItemsHorizontal extends StatelessWidget {
  const CategoryItemsHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      buildWhen: (p, c) => p.items != c.items,
      builder: (context, state) {
        if (state.items.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Text(
              'No items available',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 14.sp),
            ),
          );
        }
        return SizedBox(
          height: 190.h,
          child: ListView.separated(
            key: ValueKey(state.selectedId),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            itemCount: state.items.length,
            separatorBuilder: (_, _) => SizedBox(width: 16.w),
            itemBuilder: (context, index) => _CategoryCard(key: ValueKey(state.items[index].id), item: state.items[index]),
          ),
        );
      },
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({super.key, required this.item});
  final CategoryItem item;

  String _formatPrice(double price) => '\$24${price.toStringAsFixed(1)}';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final id = ProductIdMapper.fromTitle(item.title);
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ProductDetailPage(productId: id)),
        );
      },
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 260),
        builder: (context, value, child) => Opacity(
          opacity: value,
          child: Transform.translate(offset: Offset(0, (1 - value) * 10), child: child),
        ),
        child: Container(
          width: 150.w,
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 75.w,
                      height: 75.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Image.asset(item.image, width: 34.w, fit: BoxFit.cover),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                item.title,
                style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w700),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8.h),
              Text(
                _formatPrice(item.price),
                style: TextStyle(color: AppColors.accent, fontSize: 15.sp, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
