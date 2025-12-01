import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffeecafe/core/constants/app_strings.dart';

class DetailDescriptionBlock extends StatelessWidget {
  const DetailDescriptionBlock({super.key, required this.text, required this.expanded, required this.onToggle});
  final String text;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final display = expanded ? text : (text.length > 160 ? text.substring(0, 160) + ' ...' : text);
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.white, fontSize: 16.sp, height: 1.4),
        children: [
          TextSpan(text: display),
          if (!expanded && text.length > 160)
            WidgetSpan(
              child: GestureDetector(
                onTap: onToggle,
                child: Text(
                  ' ${AppStrings.readMore}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
