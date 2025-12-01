import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailTitleBlock extends StatelessWidget {
  const DetailTitleBlock({super.key, required this.title, required this.subtitle, required this.rating});
  final String title;
  final String subtitle;
  final double rating;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.white, fontSize: 30.sp, fontWeight: FontWeight.w700)),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: Text(
                subtitle,
                style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20.sp),
                SizedBox(width: 4.w),
                Text(rating.toStringAsFixed(1), style: TextStyle(color: Colors.white, fontSize: 16.sp)),
              ],
            ),
          ],
        )
      ],
    );
  }
}
