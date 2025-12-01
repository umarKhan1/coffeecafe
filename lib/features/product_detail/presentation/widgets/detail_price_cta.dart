import 'package:coffeecafe/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffeecafe/core/constants/app_strings.dart';
import 'package:coffeecafe/features/cart/cubit/cart_cubit.dart';
import 'package:coffeecafe/features/product_detail/cubit/product_detail_cubit.dart';
import 'package:coffeecafe/features/product_detail/cubit/product_detail_state.dart';

class DetailPriceCta extends StatelessWidget {
  const DetailPriceCta({super.key, required this.price, required this.onAdd, required this.enabled});
  final double price;
  final VoidCallback onAdd;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      builder: (context, detailState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price', style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 8.h),
            Text('\$${price.toStringAsFixed(0)}', style: TextStyle(color: Colors.white, fontSize: 30.sp, fontWeight: FontWeight.w800)),
            SizedBox(height: 16.h),
            Row(
              children: [
                _QtyButton(icon: Icons.remove, onTap: detailState.qty > 1 ? context.read<ProductDetailCubit>().decrementQty : null),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Text('${detailState.qty}', style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700)),
                ),
                _QtyButton(icon: Icons.add, onTap: context.read<ProductDetailCubit>().incrementQty),
                const Spacer(),
                Text('\$${(price * detailState.qty).toStringAsFixed(0)}', style: TextStyle(color: Colors.white, fontSize: 26.sp, fontWeight: FontWeight.w800)),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: Opacity(
                opacity: enabled ? 1 : 0.4,
                child: ElevatedButton(
                  onPressed: enabled
                      ? () {
                          final product = detailState.product;
                          if (product == null) return;
                          context.read<CartCubit>().addProduct(product, detailState.selectedMilk, detailState.qty);
                          ScaffoldMessenger.of(context).showSnackBar(
                           const  SnackBar(
                              content:  Text('Added to cart'),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary ,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                  ),
                  child: Text(AppStrings.addToCart, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onTap == null ? 0.4 : 1,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(10.r),
          child: Icon(icon, color: Colors.white, size: 18.sp),
        ),
      ),
    );
  }
}
