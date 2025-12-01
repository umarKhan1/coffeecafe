import 'package:coffeecafe/core/constants/app_assets.dart';
import 'package:coffeecafe/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffeecafe/features/cart/cubit/cart_cubit.dart';
import 'package:coffeecafe/features/cart/cubit/cart_state.dart';
import 'package:coffeecafe/features/navigation/cubit/nav_cubit.dart';

class DashboardTopHero extends StatelessWidget {
  const DashboardTopHero({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // top logo + title centered
          SizedBox(height: 8.h),
          Center(
            child: Row(
              crossAxisAlignment:  .center,
              mainAxisAlignment: .center,
              children: [
                Image.asset(
                  AppAssets.cup,
                  width: 42.w,
                  height: 42.w,
                  fit: BoxFit.cover ,
                ),
                SizedBox(width: 16.w),
                SizedBox(
                  width: 60.w,
                  child: Text(
                    AppStrings.coffeeTaste,
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 2,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // avatar left, menu right
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundImage: const AssetImage(AppAssets.avatar), // or your asset
                ),
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () => context.read<NavCubit>().setIndex(1),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            Icons.shopping_bag,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                          if (state.count > 0)
                            Positioned(
                              right: -8,
                              top: -8,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(10.r)),
                                child: Text(
                                  '${state.count}',
                                  style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // greeting text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                ),
                children: const [
                  TextSpan(text: '${AppStrings.hi} '),
                  TextSpan(
                    text: AppStrings.username,
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
