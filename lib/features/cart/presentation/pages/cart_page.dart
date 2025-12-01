import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffeecafe/core/constants/app_colors.dart';
import 'package:coffeecafe/core/constants/app_strings.dart';
import 'package:coffeecafe/features/cart/cubit/cart_cubit.dart';
import 'package:coffeecafe/features/cart/cubit/cart_state.dart';
import 'package:coffeecafe/features/cart/models/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF140F11),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(AppStrings.cartTitle, style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state.items.isEmpty) {
              return Center(
                child: Text(AppStrings.cartEmpty, style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 16.sp)),
              );
            }
            final delivery = 49.0; // can be from repo later
            final taxes = (state.total + delivery) * 0.06487; // mock to resemble screenshot
            final grandTotal = state.total + delivery + taxes;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: state.items.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (context, i) {
                        final item = state.items[i];
                        return Dismissible(
                          key: ValueKey(item.id),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) => context.read<CartCubit>().remove(item.id),
                          background: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 64.w,
                              height: 64.w,
                              decoration: BoxDecoration(
                                color: Colors.red.shade400,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Icon(Icons.delete, color: Colors.white, size: 22.sp),
                            ),
                          ),
                          child: _CartCard(item: item),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // totals
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkCard,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _RowLabelValue(label: AppStrings.cartSubtotal, value: '₹${state.total.toStringAsFixed(2)}'),
                        SizedBox(height: 8.h),
                        _Divider(),
                        SizedBox(height: 8.h),
                        _RowLabelValue(label: AppStrings.cartDelivery, value: '₹${delivery.toStringAsFixed(0)}'),
                        SizedBox(height: 8.h),
                        _RowLabelValue(label: AppStrings.cartTaxes, value: '₹${taxes.toStringAsFixed(2)}'),
                        SizedBox(height: 12.h),
                        _Divider(),
                        SizedBox(height: 12.h),
                        _RowLabelValue(label: AppStrings.cartGrandTotal, value: '₹${grandTotal.toStringAsFixed(2)}', emphasize: true),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEADFB3), // theme-like pale
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 18.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                      ),
                      child: Text(AppStrings.cartPayNow, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      color: Colors.white.withValues(alpha: 0.15),
    );
  }
}

class _RowLabelValue extends StatelessWidget {
  const _RowLabelValue({required this.label, required this.value, this.emphasize = false});
  final String label;
  final String value;
  final bool emphasize;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: emphasize ? 22.sp : 16.sp,
            fontWeight: emphasize ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: emphasize ? 22.sp : 16.sp,
            fontWeight: emphasize ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _CartCard extends StatelessWidget {
  const _CartCard({required this.item});
  final CartItem item;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(22.r),
      ),
      padding: EdgeInsets.all(12.w),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: 64.w,
              height: 64.w,
              color: Colors.white.withValues(alpha: 0.08),
              child: const Icon(Icons.local_cafe, color: Colors.white),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700)),
                if (item.milk != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    item.milk!.name,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 13.sp),
                  ),
                ],
                SizedBox(height: 6.h),
                Text('₹${item.unitPrice.toStringAsFixed(0)}', style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          _QtyButton(
            icon: Icons.remove,
            onTap: item.qty > 1 ? () => context.read<CartCubit>().updateQty(item.id, item.qty - 1) : null,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(10.r)),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              child: Text('${item.qty}', style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
            ),
          ),
          _QtyButton(icon: Icons.add, onTap: () => context.read<CartCubit>().updateQty(item.id, item.qty + 1)),
        ],
      ),
    );
  }
}

// reuse qty button
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
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.all(8.r),
          child: Icon(icon, color: Colors.white, size: 16.sp),
        ),
      ),
    );
  }
}
