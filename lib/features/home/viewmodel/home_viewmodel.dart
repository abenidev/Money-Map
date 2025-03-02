import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_map/core/models/user.dart';
import 'package:money_map/features/home/repositories/user_local_repository.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModelNotifier, User?>((ref) {
  final userLocalRepository = ref.watch(userLocalRepositoryProvider);
  return HomeViewModelNotifier(
    userLocalRepository: userLocalRepository,
  );
});

class HomeViewModelNotifier extends StateNotifier<User?> {
  UserLocalRepository userLocalRepository;
  HomeViewModelNotifier({
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
