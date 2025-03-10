import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_map/core/models/user.dart';
import 'package:money_map/features/home/repositories/user_local_repository.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewmodelNotifier, User?>((ref) {
  final userLocalRepository = ref.watch(userLocalRepositoryProvider);
  return HomeViewmodelNotifier(
    userLocalRepository: userLocalRepository,
  );
});

class HomeViewmodelNotifier extends StateNotifier<User?> {
  UserLocalRepository userLocalRepository;
  HomeViewmodelNotifier({
    required this.userLocalRepository,
  }) : super(null);

  User? updateUserStateFromBox({bool setState = true}) {
    User? userFromBox = userLocalRepository.getUserFromBox();
    if (setState) state = userFromBox;
    return userFromBox;
  }

  void clearUser() {
    state = null;
  }
}
