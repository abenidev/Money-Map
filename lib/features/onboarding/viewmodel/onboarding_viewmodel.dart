import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_map/core/constants/data/categories_data.dart';
import 'package:money_map/core/models/account.dart';
import 'package:money_map/core/models/user.dart';
import 'package:money_map/core/services/object_box_service.dart';
import 'package:nb_utils/nb_utils.dart';

final onboardingViewmodelNotifierProvider = StateNotifierProvider<OnboardingViewmodelNotifier, void>((ref) {
  return OnboardingViewmodelNotifier();
});

class OnboardingViewmodelNotifier extends StateNotifier<void> {
  OnboardingViewmodelNotifier() : super(null);

  bool isUserSettedUp() {
    return ObjectBoxHelper.usersBox.count() > 0;
  }

  Future<void> setIsWelcomeViewedVal(bool newVal) async {
    await setValue('isWelcomeViewed', newVal);
  }

  bool getIsWelcomeViewedVal() {
    return getBoolAsync('isWelcomeViewed');
  }

  addNewUserToBox(User newUser, {bool loadDefaultCategories = false}) {
    Account newAccount = Account(name: 'Default', currency: newUser.currency, isDefault: true);
    if (loadDefaultCategories) ObjectBoxHelper.categoriesBox.putMany(categoriesData);
    newAccount.user.target = newUser;
    newUser.accounts.add(newAccount);
    ObjectBoxHelper.usersBox.put(newUser);
  }
}
