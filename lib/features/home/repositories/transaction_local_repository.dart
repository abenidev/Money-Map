import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_map/core/constants/app_enums/transaction_type.dart';
import 'package:money_map/core/models/account.dart';
import 'package:money_map/core/models/category.dart';
import 'package:money_map/core/models/transaction.dart';
import 'package:money_map/core/services/object_box_service.dart';
import 'package:money_map/features/home/repositories/account_local_repository.dart';
import 'package:money_map/features/home/repositories/cateogries_local_repository.dart';
import 'package:money_map/objectbox.g.dart';

final transactionLocalRepositoryProvider = StateProvider<TransactionLocalRepository>((ref) {
  final categoriesLocalRepository = ref.watch(categoriesLocalRepositoryProvider);
  final accountLocalRepository = ref.watch(accountLocalProvider);
  return TransactionLocalRepository(
    categoriesLocalRepository: categoriesLocalRepository,
    accountLocalRepository: accountLocalRepository,
  );
});

class TransactionLocalRepository {
  CateogriesLocalRepository categoriesLocalRepository;
  AccountLocalRepository accountLocalRepository;
  TransactionLocalRepository({
    required this.categoriesLocalRepository,
    required this.accountLocalRepository,
  });

  List<Transaction> getAllTransactions() {
    return ObjectBoxHelper.transactionsBox.getAll();
  }

  List<Transaction> getIncomeTransactions() {
    Query<Transaction> builder = ObjectBoxHelper.transactionsBox.query(Transaction_.transactionType.equals(TransactionType.income.name)).build();
    List<Transaction> transactions = builder.find();
    builder.close();
    return transactions;
  }

  List<Transaction> getExpenseTransactions() {
    Query<Transaction> builder = ObjectBoxHelper.transactionsBox.query(Transaction_.transactionType.equals(TransactionType.expense.name)).build();
    List<Transaction> transactions = builder.find();
    builder.close();
    return transactions;
  }

  List<Transaction> getCurrentMonthTransactions() {
    DateTime now = DateTime.now();
    // Get the first and last day of the current month
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
    // Query transactions within this range
    Query<Transaction> builder = ObjectBoxHelper.transactionsBox
        .query(Transaction_.createdAt.greaterOrEqual(startOfMonth.millisecondsSinceEpoch).and(Transaction_.createdAt.lessOrEqual(endOfMonth.millisecondsSinceEpoch)))
        .build();
    List<Transaction> transactions = builder.find();
    builder.close();
    return transactions;
  }

  void addTransaction(
    double amount,
    String? description,
    TransactionType transactionType,
    Category category,
    Account account,
  ) {
    Transaction newTransaction = Transaction(
      amount: amount,
      transactionType: transactionType.name,
      description: description,
    );
    newTransaction.account.target = account;
    newTransaction.category.target = category;
    category.transactions.add(newTransaction);
    account.transactions.add(newTransaction);
    ObjectBoxHelper.transactionsBox.put(newTransaction);
  }

  void removeTransaction(Transaction transaction) {
    ObjectBoxHelper.transactionsBox.remove(transaction.id);
  }
}
