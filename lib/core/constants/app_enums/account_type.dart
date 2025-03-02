enum AccountType {
  personal,
  business,
  bank,
  cash,
  credit,
  investment,
}

extension AccountTypeExtension on AccountType {
  String get name {
    switch (this) {
      case AccountType.personal:
        return 'Personal';
      case AccountType.business:
        return 'Business';
      case AccountType.bank:
        return 'Bank';
      case AccountType.cash:
        return 'Cash';
      case AccountType.credit:
        return 'Credit';
      case AccountType.investment:
        return 'Investment';
    }
  }
}

extension AccountTypeStringExtension on String {
  AccountType get toAccountType {
    switch (this) {
      case 'Personal':
        return AccountType.personal;
      case 'Business':
        return AccountType.business;
      case 'Bank':
        return AccountType.bank;
      case 'Cash':
        return AccountType.cash;
      case 'Credit':
        return AccountType.credit;
      case 'Investment':
        return AccountType.investment;
      default:
        throw ArgumentError('Invalid account type: $this');
    }
  }
}
