import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffeecafe/core/constants/app_colors.dart';
import 'package:coffeecafe/features/cart/cubit/cart_cubit.dart';
import 'package:coffeecafe/features/cart/models/cart_item.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({super.key, required this.item});
  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.darkCard, borderRadius: BorderRadius.circular(16.r)),
      padding: EdgeInsets.all(12.w),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: 56.w,
              height: 56.w,
              color: Colors.white.withValues(alpha: 0.1),
              child: const Icon(Icons.local_cafe, color: Colors.white),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
                if (item.milk != null) ...[
                  SizedBox(height: 4.h),
                  Text(item.milk!.name, style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12.sp)),
                ],
                SizedBox(height: 6.h),
                Text('₹${item.unitPrice.toStringAsFixed(0)}', style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          _QtyButton(
            icon: Icons.remove,
            onTap: item.qty > 1 ? () => context.read<CartCubit>().updateQty(item.id, item.qty - 1) : null,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text('${item.qty}', style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
          ),
          _QtyButton(icon: Icons.add, onTap: () => context.read<CartCubit>().updateQty(item.id, item.qty + 1)),
          SizedBox(width: 10.w),
          InkWell(
            onTap: () => context.read<CartCubit>().remove(item.id),
            child: Container(
              decoration: BoxDecoration(color: Colors.red.shade400, borderRadius: BorderRadius.circular(12.r)),
              padding: EdgeInsets.all(10.r),
              child: Icon(Icons.delete, color: Colors.white, size: 18.sp),
            ),
          ),
        ],
      ),
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
          padding: EdgeInsets.all(8.r),
          child: Icon(icon, color: Colors.white, size: 16.sp),
        ),
      ),
    );
  }
}
