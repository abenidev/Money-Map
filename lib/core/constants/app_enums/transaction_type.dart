enum TransactionType {
  expense,
  income,
}

extension TransactionTypeExtension on TransactionType {
  String get name {
    switch (this) {
      case TransactionType.expense:
        return 'Expense';
      case TransactionType.income:
        return 'Income';
    }
  }
}

extension TransactionTypeStringExtension on String {
  TransactionType get toTransactionType {
    switch (this) {
      case 'Expense':
        return TransactionType.expense;
      case 'Income':
        return TransactionType.income;
      default:
        throw ArgumentError('Invalid transaction type: $this');
    }
  }
}
