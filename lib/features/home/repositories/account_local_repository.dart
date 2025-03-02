import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_map/core/models/account.dart';
import 'package:money_map/core/services/object_box_service.dart';
import 'package:money_map/objectbox.g.dart';

final accountLocalProvider = StateProvider<AccountLocalRepository>((ref) {
  return AccountLocalRepository();
});

class AccountLocalRepository {
  AccountLocalRepository();

  List<Account> getAllAccounts() {
    return ObjectBoxHelper.accountsBox.getAll();
  }

  Account? getAccountById(int id) {
    return ObjectBoxHelper.accountsBox.get(id);
  }

  Account getDefaultAccount() {
    Query<Account?> builder = ObjectBoxHelper.accountsBox.query(Account_.isDefault.equals(true)).build();
    Account? account = builder.findFirst();
    builder.close();
    if (account == null) throw Exception('No default account found');
    return account;
  }

  void updateAccountBalance(int id, double balance) {
    Account? account = getAccountById(id);
    if (account == null) throw Exception('Account not found');
    if (account.user.target == null) throw Exception('User not linked with account');
    account.balance = balance;
    ObjectBoxHelper.accountsBox.put(account);
  }
}
