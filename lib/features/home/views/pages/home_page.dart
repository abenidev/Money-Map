import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:money_map/core/constants/app_enums/transaction_type.dart';
import 'package:money_map/core/models/transaction.dart';
import 'package:money_map/core/models/user.dart';
import 'package:money_map/core/utils/app_utils.dart';
import 'package:money_map/features/home/viewmodel/home_viewmodel.dart';
import 'package:money_map/features/home/viewmodel/transaction_viewmodel.dart';
import 'package:money_map/features/home/views/pages/expense_add_page.dart';
import 'package:money_map/features/home/views/pages/income_add_page.dart';
import 'package:money_map/features/home/views/widgets/amount_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    User? currentUser = ref.watch(homeViewModelProvider);
    List<Transaction> currentMonthTransactions = ref.watch(transactionViewmodelProvider);
    double totalIncome = ref.watch(transactionViewmodelProvider.notifier).getTotalIncomeAmount();
    double totalExpense = ref.watch(transactionViewmodelProvider.notifier).getTotalExpenseAmount();

    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error, user cannot be null!'),
        ),
      );
    }

    return Scaffold(
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
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sh(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: AmountWidget(
                amount: getCurrencyFormatedStr(((totalIncome * ((100 - currentUser.tithePercentage) / 100)) - totalExpense)),
                amountFontSize: 26.sp,
              ),
            ),
            sh(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text('Transactions (${getFormatedDate(now, format: 'MMM')})', style: TextStyle(fontSize: 12.sp)),
            ),
            sh(15),
            Expanded(
              child: GroupedListView<Transaction, int>(
                elements: currentMonthTransactions,
                groupBy: (transaction) => transaction.createdAt.day,
                groupHeaderBuilder: (transaction) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(getFormatedDate(transaction.createdAt, format: 'EEEE, MMM d'), style: TextStyle(fontSize: 12.sp)),
                      ],
                    ),
                  );
                },
                itemBuilder: (context, Transaction transaction) {
                  int lastItemIndex = currentMonthTransactions.indexOf(transaction);
                  bool isLastItem = lastItemIndex == 0;

                  return Padding(
                    padding: isLastItem ? EdgeInsets.only(bottom: 70.h) : EdgeInsets.zero,
                    child: ListTile(
                      onTap: () {},
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Delete Transaction', style: TextStyle(fontSize: 14.sp)),
                              content: Text('Are you sure you want to delete transaction?', style: TextStyle(fontSize: 12.sp)),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'No',
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    ref.read(transactionViewmodelProvider.notifier).removeTransaction(transaction);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      title: Text(
                        'Br. ${getCurrencyFormatedStr(transaction.amount)}',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      subtitle: Text(
                        '${transaction.category.target?.name}',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      leading: Icon(
                        transaction.transactionType.toTransactionType == TransactionType.expense ? Icons.money_off : Icons.money,
                        color: transaction.transactionType.toTransactionType == TransactionType.expense ? Colors.red : Colors.green.shade900,
                        size: 24.w,
                      ),
                      trailing: Text(
                        formatTo12Hour(transaction.createdAt.hour, transaction.createdAt.minute),
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ),
                  );
                },
                itemComparator: (item1, item2) => item1.createdAt.compareTo(item2.createdAt),
                useStickyGroupSeparators: true, // optional
                floatingHeader: true, // optional
                order: GroupedListOrder.DESC, // optional
                // footer: Text("Widget at the bottom of list"), // optional
              ),
            ),
          ],
        ),
      ),
    );
  }
}
