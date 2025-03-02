import 'dart:convert';
import 'package:money_map/core/models/category.dart';
import 'package:objectbox/objectbox.dart';
import 'package:money_map/core/constants/app_enums/transaction_type.dart';
import 'package:money_map/core/models/account.dart';

@Entity()
class Transaction {
  @Id()
  int id;
  double amount;
  String transactionType;
  String? description;
  DateTime createdAt;
  DateTime updatedAt;

  Transaction({
    this.id = 0,
    required this.amount,
    this.description,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? transactionType,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now(),
        transactionType = transactionType ?? TransactionType.income.name;

  ToOne<Account> account = ToOne<Account>();
  ToOne<Category> category = ToOne<Category>();

  Transaction copyWith({
    int? id,
    double? amount,
    String? transactionType,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      transactionType: transactionType ?? this.transactionType,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'transactionType': transactionType,
      'description': description,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as int,
      amount: map['amount'] as double,
      transactionType: map['transactionType'] as String,
      description: map['description'] != null ? map['description'] as String : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) => Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transaction(id: $id, amount: $amount, transactionType: $transactionType, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.amount == amount &&
        other.transactionType == transactionType &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ amount.hashCode ^ transactionType.hashCode ^ description.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
  }
}
