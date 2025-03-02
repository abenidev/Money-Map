import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_map/core/models/category.dart';
import 'package:money_map/core/models/transaction.dart';
import 'package:money_map/core/models/user.dart';
import 'package:money_map/core/utils/app_utils.dart';
import 'package:money_map/features/home/viewmodel/account_viewmodel.dart';
import 'package:money_map/features/home/viewmodel/categories_viewmodel.dart';
import 'package:money_map/features/home/viewmodel/home_viewmodel.dart';
import 'package:money_map/features/home/viewmodel/transaction_viewmodel.dart';
import 'package:money_map/features/home/views/pages/expense_add_page.dart';
import 'package:money_map/features/home/views/pages/income_add_page.dart';
import 'package:nb_utils/nb_utils.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      ref.read(homeViewModelProvider.notifier).updateUserStateFromBox();
      ref.read(transactionViewmodelProvider.notifier).updateCurrentMonthTransactionsListState();
      ref.read(categoriesViewmodelProvider.notifier).updateCategoriesState();
      ref.read(accountViewmodelProvider.notifier).updateAccountsState();
    });
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = ref.watch(homeViewModelProvider);
    List<Transaction> currentMonthTransactions = ref.watch(transactionViewmodelProvider);

    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error, user cannot be null!'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          getFormatedDate(now, format: 'EEEE, MMM d'),
          style: TextStyle(fontSize: 16.sp),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings, size: 22.w),
          ),
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        type: ExpandableFabType.up,
        distance: 75,
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: Icon(Icons.add, size: 22.w),
          fabSize: ExpandableFabSize.regular,
        ),
        closeButtonBuilder: DefaultFloatingActionButtonBuilder(
          child: Icon(Icons.close, size: 22.w),
          fabSize: ExpandableFabSize.regular,
        ),
        children: [
          Row(
            children: [
              Text('Income', style: TextStyle(fontSize: 12.sp)),
              SizedBox(width: 10.w),
              FloatingActionButton.small(
                heroTag: 'income',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const IncomeAddPage()));
                },
                child: Icon(Icons.arrow_downward, size: 22.w),
              ),
            ],
          ),
          Row(
            children: [
              Text('Expense', style: TextStyle(fontSize: 12.sp)),
              SizedBox(width: 10.w),
              FloatingActionButton.small(
                heroTag: 'expense',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ExpenseAddPage()));
                },
                child: Icon(Icons.arrow_upward, size: 22.w, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sh(10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  currentUser.accounts.first.balance.toStringAsFixed(2),
                  style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 5.w),
                Text('Br', style: TextStyle(fontSize: 12.sp)),
              ],
            ),
            sh(10),
            Text('Transactions (${getFormatedDate(now, format: 'MMM')})', style: TextStyle(fontSize: 12.sp)),
            sh(5),
          ],
        ),
      ),
    );
  }
}
