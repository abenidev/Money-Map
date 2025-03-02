import 'package:money_map/core/constants/app_enums/transaction_type.dart';
import 'package:money_map/core/models/category.dart';

List<Category> categoriesData = [
  Category(name: 'Groceries', type: TransactionType.expense.name),
  Category(name: 'Restaurants', type: TransactionType.expense.name),
  Category(name: 'Entertainment', type: TransactionType.expense.name),
  Category(name: 'Shopping', type: TransactionType.expense.name),
  Category(name: 'Transportation', type: TransactionType.expense.name),
  Category(name: 'Utilities', type: TransactionType.expense.name),
  Category(name: 'Healthcare', type: TransactionType.expense.name),
  Category(name: 'Education', type: TransactionType.expense.name),
  Category(name: 'Clothing', type: TransactionType.expense.name),
  Category(name: 'Gifts', type: TransactionType.expense.name),
  Category(name: 'Other Expenses', type: TransactionType.expense.name),
  //
  Category(name: 'Android In App Purchases', type: TransactionType.income.name),
  Category(name: 'IOS In App Purchases', type: TransactionType.income.name),
  Category(name: 'Salary', type: TransactionType.income.name),
  Category(name: 'Investments', type: TransactionType.income.name),
  Category(name: 'Rents', type: TransactionType.income.name),
  Category(name: 'Dividends', type: TransactionType.income.name),
  Category(name: 'Gifts', type: TransactionType.income.name),
  Category(name: 'Freelancing', type: TransactionType.income.name),
  Category(name: 'Other Income', type: TransactionType.income.name),
];
