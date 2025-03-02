import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_map/core/models/category.dart';
import 'package:money_map/features/home/viewmodel/categories_viewmodel.dart';

class IncomeAddPage extends ConsumerStatefulWidget {
  const IncomeAddPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IncomeAddPageState();
}

class _IncomeAddPageState extends ConsumerState<IncomeAddPage> {
  @override
  Widget build(BuildContext context) {
    List<Category> categories = ref.watch(categoriesViewmodelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Income',
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
    );
  }
}
