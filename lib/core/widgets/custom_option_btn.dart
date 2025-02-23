import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOptionBtn extends ConsumerWidget {
  const CustomOptionBtn({super.key, required this.child, required this.onTap});
  final Widget child;
  final Function() onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.w),
          border: Border.all(
            width: 0.5,
          ),
        ),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
        child: child,
      ),
    );
  }
}
