import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

final onboardingViewmodelNotifierProvider = StateNotifierProvider<OnboardingViewmodelNotifier, void>((ref) {
  return OnboardingViewmodelNotifier();
});

class OnboardingViewmodelNotifier extends StateNotifier<void> {
  OnboardingViewmodelNotifier() : super(null);

  Future<void> setIsWelcomeViewedVal(bool newVal) async {
    await setValue('isWelcomeViewed', newVal);
  }

  bool getIsWelcomeViewedVal() {
    return getBoolAsync('isWelcomeViewed');
  }
}
