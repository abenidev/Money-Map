import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AmountWidget extends ConsumerWidget {
  AmountWidget({
    super.key,
    required this.amount,
    double? amountFontSize,
    double? symbolFontSize,
  })  : amountFontSize = amountFontSize ?? 32.sp,
        symbolFontSize = symbolFontSize ?? 12.sp;

  final String amount;
  final double amountFontSize;
  final double symbolFontSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          amount,
          style: TextStyle(fontSize: amountFontSize, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 5.w),
        Text('Br', style: TextStyle(fontSize: symbolFontSize)),
      ],
    );
  }
}
