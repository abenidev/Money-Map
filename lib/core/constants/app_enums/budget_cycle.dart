enum BudgetCycle {
  monthly,
  weekly,
  yearly,
}

extension BudgetCycleExtension on BudgetCycle {
  String get name {
    switch (this) {
      case BudgetCycle.monthly:
        return 'Monthly';
      case BudgetCycle.weekly:
        return 'Weekly';
      case BudgetCycle.yearly:
        return 'Yearly';
    }
  }
}

extension BudgetCycleStringExtension on String {
  BudgetCycle get toBudgetCycle {
    switch (this) {
      case 'Monthly':
        return BudgetCycle.monthly;
      case 'Weekly':
        return BudgetCycle.weekly;
      case 'Yearly':
        return BudgetCycle.yearly;
      default:
        throw ArgumentError('Invalid budget cycle: $this');
    }
  }
}
