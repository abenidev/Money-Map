import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  addNewUserToBox(User newUser) {
    ObjectBoxHelper.usersBox.put(newUser);
  }
}
