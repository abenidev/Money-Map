import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpenseAddPage extends ConsumerStatefulWidget {
  const ExpenseAddPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExpenseAddPageState();
}

class _ExpenseAddPageState extends ConsumerState<ExpenseAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Expense',
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
    );
  }
}
