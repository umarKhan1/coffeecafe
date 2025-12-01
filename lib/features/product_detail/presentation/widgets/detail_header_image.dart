import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailHeaderImage extends StatelessWidget {
  const DetailHeaderImage({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28.r),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.asset(image, fit: BoxFit.cover),
      ),
    );
  }
}
