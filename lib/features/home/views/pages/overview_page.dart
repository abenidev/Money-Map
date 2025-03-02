import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_map/core/models/user.dart';
import 'package:money_map/core/utils/app_utils.dart';
import 'package:money_map/features/home/viewmodel/home_viewmodel.dart';
import 'package:money_map/features/home/viewmodel/transaction_viewmodel.dart';
import 'package:money_map/features/home/views/widgets/amount_widget.dart';

class OverviewPage extends ConsumerStatefulWidget {
  const OverviewPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OverviewPageState();
}

class _OverviewPageState extends ConsumerState<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    User? currentUser = ref.watch(homeViewModelProvider);
    // List<Transaction> currentMonthTransactions = ref.watch(transactionViewmodelProvider);
    // List<Transaction> incomeTransactions = ref.watch(transactionViewmodelProvider.notifier).getIncomeTransactions();
    // List<Transaction> expenseTransactions = ref.watch(transactionViewmodelProvider.notifier).getExpenseTransactions();
    double totalIncome = ref.watch(transactionViewmodelProvider.notifier).getTotalIncomeAmount();
    double totalExpense = ref.watch(transactionViewmodelProvider.notifier).getTotalExpenseAmount();
    double totalNet = totalIncome - totalExpense;

    if (currentUser == null) throw Exception('Current user cannot be null at this state!');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Overview',
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sh(10),
            Text('Net Total', style: TextStyle(fontSize: 12.sp)),
            sh(5),
            AmountWidget(
              amount: getCurrencyFormatedStr(totalNet),
              amountFontSize: 24.sp,
            ),
            Divider(),
            sh(3),
            Text('Total Income', style: TextStyle(fontSize: 12.sp)),
            sh(2),
            AmountWidget(
              amount: getCurrencyFormatedStr(totalIncome),
              amountFontSize: 14.sp,
            ),
            sh(10),
            Text('Total Expense', style: TextStyle(fontSize: 12.sp)),
            sh(2),
            AmountWidget(
              amount: getCurrencyFormatedStr(totalExpense),
              amountFontSize: 14.sp,
            ),
            sh(20),
            Text('Total', style: TextStyle(fontSize: 12.sp)),
            Divider(),
            sh(3),
            Text('Needs', style: TextStyle(fontSize: 12.sp)),
            sh(2),
            AmountWidget(
              amount: getCurrencyFormatedStr(totalIncome * (currentUser.needsPercentage / 100)),
              amountFontSize: 16.sp,
            ),
            sh(3),
            Text('Wants', style: TextStyle(fontSize: 12.sp)),
            sh(2),
            AmountWidget(
              amount: getCurrencyFormatedStr(totalIncome * (currentUser.wantsPercentage / 100)),
              amountFontSize: 16.sp,
            ),
            sh(3),
            Text('Savings', style: TextStyle(fontSize: 12.sp)),
            sh(2),
            AmountWidget(
              amount: getCurrencyFormatedStr(totalIncome * (currentUser.savingsPercentage / 100)),
              amountFontSize: 16.sp,
            ),
            sh(3),
            Text('Tithe', style: TextStyle(fontSize: 12.sp)),
            sh(2),
            AmountWidget(
              amount: getCurrencyFormatedStr(totalIncome * (currentUser.tithePercentage / 100)),
              amountFontSize: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}
