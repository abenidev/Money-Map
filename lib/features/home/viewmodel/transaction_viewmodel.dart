import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_map/core/constants/app_enums/transaction_type.dart';
import 'package:money_map/core/models/account.dart';
import 'package:money_map/core/models/category.dart';
import 'package:money_map/core/models/transaction.dart';
import 'package:money_map/features/home/repositories/transaction_local_repository.dart';
import 'package:money_map/features/home/viewmodel/account_viewmodel.dart';
import 'package:money_map/features/home/viewmodel/home_viewmodel.dart';

final transactionViewmodelProvider = StateNotifierProvider<TransactionViewmodelNotifier, List<Transaction>>((ref) {
  final transactionLocalRepository = ref.watch(transactionLocalRepositoryProvider);
  final accountViewmodelNotifier = ref.watch(accountViewmodelProvider.notifier);
  final homeViewmodelNotifier = ref.watch(homeViewModelProvider.notifier);
  return TransactionViewmodelNotifier(
    transactionLocalRepository: transactionLocalRepository,
    accountViewmodelNotifier: accountViewmodelNotifier,
    homeViewmodelNotifier: homeViewmodelNotifier,
  );
});

class TransactionViewmodelNotifier extends StateNotifier<List<Transaction>> {
  TransactionLocalRepository transactionLocalRepository;
  AccountViewmodelNotifier accountViewmodelNotifier;
  HomeViewmodelNotifier homeViewmodelNotifier;
  TransactionViewmodelNotifier({
    required this.transactionLocalRepository,
    required this.accountViewmodelNotifier,
    required this.homeViewmodelNotifier,
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
    double balance = account.balance;
    if (transactionType == TransactionType.expense) {
      balance = balance - amount;
    } else if (transactionType == TransactionType.income) {
      balance = balance + amount;
    }
    accountViewmodelNotifier.updateAccountBalance(account.id, balance);
    updateCurrentMonthTransactionsListState();
    homeViewmodelNotifier.updateUserStateFromBox();
  }
}
