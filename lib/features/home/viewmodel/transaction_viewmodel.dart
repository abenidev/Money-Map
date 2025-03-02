import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_map/core/constants/app_enums/transaction_type.dart';
import 'package:money_map/core/models/account.dart';
import 'package:money_map/core/models/category.dart';
import 'package:money_map/core/models/transaction.dart';
import 'package:money_map/features/home/repositories/transaction_local_repository.dart';
import 'package:money_map/features/home/viewmodel/account_viewmodel.dart';

final transactionViewmodelProvider = StateNotifierProvider<TransactionViewmodelNotifier, List<Transaction>>((ref) {
  final transactionLocalRepository = ref.watch(transactionLocalRepositoryProvider);
  final accountViewmodelNotifier = ref.watch(accountViewmodelProvider.notifier);
  return TransactionViewmodelNotifier(
    transactionLocalRepository: transactionLocalRepository,
    accountViewmodelNotifier: accountViewmodelNotifier,
  );
});

class TransactionViewmodelNotifier extends StateNotifier<List<Transaction>> {
  TransactionLocalRepository transactionLocalRepository;
  AccountViewmodelNotifier accountViewmodelNotifier;
  TransactionViewmodelNotifier({
    required this.transactionLocalRepository,
    required this.accountViewmodelNotifier,
  }) : super([]);

  void updateCurrentMonthTransactionsListState() {
    List<Transaction> currentMonthTransactionsList = transactionLocalRepository.getCurrentMonthTransactions();
    state = currentMonthTransactionsList;
  }

  List<Transaction> getAllTransactions() {
    return transactionLocalRepository.getAllTransactions();
  }

  void addTransaction(
    double amount,
    String? description,
    TransactionType transactionType,
    Category category,
    Account account,
  ) {
    transactionLocalRepository.addTransaction(
      amount,
      description,
      transactionType,
      category,
      account,
    );

    if (transactionType == TransactionType.expense) {
      double balance = account.balance - amount;
      accountViewmodelNotifier.updateAccountBalance(account.id, balance);
    } else if (transactionType == TransactionType.income) {
      double balance = account.balance + amount;
      accountViewmodelNotifier.updateAccountBalance(account.id, balance);
    }

    updateCurrentMonthTransactionsListState();
  }
}
