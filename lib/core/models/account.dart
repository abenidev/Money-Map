import 'dart:convert';
import 'package:objectbox/objectbox.dart';
import 'package:money_map/core/constants/app_enums/account_type.dart';
import 'package:money_map/core/models/transaction.dart';
import 'package:money_map/core/models/user.dart';

@Entity()
class Account {
  @Id()
  int id;
  String name;
  bool isDefault;
  String accountType;
  double balance;
  String currency;
  DateTime createdAt;
  DateTime updatedAt;

  Account({
    this.id = 0,
    required this.name,
    this.isDefault = false,
    String? accountType,
    this.balance = 0.0,
    required this.currency,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now(),
        accountType = accountType ?? AccountType.personal.name;

  ToOne<User> user = ToOne<User>();
  @Backlink('account')
  ToMany<Transaction> transactions = ToMany<Transaction>();

  Account copyWith({
    int? id,
    String? name,
    bool? isDefault,
    String? accountType,
    double? balance,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      isDefault: isDefault ?? this.isDefault,
      accountType: accountType ?? this.accountType,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'isDefault': isDefault,
      'accountType': accountType,
      'balance': balance,
      'currency': currency,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'] as int,
      name: map['name'] as String,
      isDefault: map['isDefault'] as bool,
      accountType: map['accountType'] as String,
      balance: map['balance'] as double,
      currency: map['currency'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) => Account.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Account(id: $id, name: $name, isDefault: $isDefault, accountType: $accountType, balance: $balance, currency: $currency, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Account other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.isDefault == isDefault &&
        other.accountType == accountType &&
        other.balance == balance &&
        other.currency == currency &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ isDefault.hashCode ^ accountType.hashCode ^ balance.hashCode ^ currency.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
  }
}
