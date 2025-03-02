enum CurrencyType {
  usd,
  etb,
}

extension CurrencyTypeExtension on CurrencyType {
  String get name {
    switch (this) {
      case CurrencyType.usd:
        return 'USD';
      case CurrencyType.etb:
        return 'ETB';
    }
  }
}

extension CurrencyTypeStringExtension on String {
  CurrencyType get toCurrencyType {
    switch (this) {
      case 'USD':
        return CurrencyType.usd;
      case 'ETB':
        return CurrencyType.etb;
      default:
        throw ArgumentError('Invalid currency type: $this');
    }
  }
}
