import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_map/core/constants/app_enums/transaction_type.dart';
import 'package:money_map/core/models/account.dart';
import 'package:money_map/core/models/category.dart';
import 'package:money_map/features/home/viewmodel/account_viewmodel.dart';
import 'package:money_map/features/home/viewmodel/categories_viewmodel.dart';
import 'package:money_map/features/home/viewmodel/transaction_viewmodel.dart';

class IncomeAddPage extends ConsumerStatefulWidget {
  const IncomeAddPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IncomeAddPageState();
}

class _IncomeAddPageState extends ConsumerState<IncomeAddPage> {
  @override
  Widget build(BuildContext context) {
    List<Category> categories = ref.watch(categoriesViewmodelProvider);
    List<Account> accounts = ref.watch(accountViewmodelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Income',
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                ref.read(transactionViewmodelProvider.notifier).addTransaction(
                      24.5,
                      'description',
                      TransactionType.expense,
                      categories[0],
                      accounts[0],
                    );
              },
              child: Text('add'),
            )
          ],
        ),
      ),
    );
  }
}
