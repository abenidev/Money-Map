import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_map/core/models/account.dart';
import 'package:money_map/features/home/repositories/account_local_repository.dart';

final accountViewmodelProvider = StateNotifierProvider<AccountViewmodelNotifier, List<Account>>((ref) {
  final accountLocalRepository = ref.watch(accountLocalProvider);
  return AccountViewmodelNotifier(
    accountLocalRepository: accountLocalRepository,
  );
});

class AccountViewmodelNotifier extends StateNotifier<List<Account>> {
  AccountLocalRepository accountLocalRepository;
  AccountViewmodelNotifier({
    required this.accountLocalRepository,
  }) : super([]);

  void updateAccountsState() {
    state = getAllAccounts();
  }

  List<Account> getAllAccounts() {
    return accountLocalRepository.getAllAccounts();
  }

  Account? getAccountById(int id) {
    return accountLocalRepository.getAccountById(id);
  }

  Account getDefaultAccount() {
    return accountLocalRepository.getDefaultAccount();
  }

  void updateAccountBalance(int id, double balance) {
    accountLocalRepository.updateAccountBalance(id, balance);
    updateAccountsState();
  }
}
