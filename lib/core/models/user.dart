import 'dart:convert';
import 'package:money_map/core/models/account.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id()
  int id;
  String name;
  String currency;
  String profilePic;
  String budgetCycle;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    this.id = 0,
    required this.name,
    required this.currency,
    required this.profilePic,
    required this.budgetCycle,
    required this.createdAt,
    required this.updatedAt,
  });

  @Backlink('user')
  ToMany<Account> accounts = ToMany<Account>();

  User copyWith({
    int? id,
    String? name,
    String? currency,
    String? profilePic,
    String? budgetCycle,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      currency: currency ?? this.currency,
      profilePic: profilePic ?? this.profilePic,
      budgetCycle: budgetCycle ?? this.budgetCycle,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'currency': currency,
      'profilePic': profilePic,
      'budgetCycle': budgetCycle,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      currency: map['currency'] as String,
      profilePic: map['profilePic'] as String,
      budgetCycle: map['budgetCycle'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, currency: $currency, profilePic: $profilePic, budgetCycle: $budgetCycle, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.currency == currency &&
        other.profilePic == profilePic &&
        other.budgetCycle == budgetCycle &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ currency.hashCode ^ profilePic.hashCode ^ budgetCycle.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
  }
}
