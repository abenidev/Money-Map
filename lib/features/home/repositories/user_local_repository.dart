import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_map/core/models/user.dart';
import 'package:money_map/core/services/object_box_service.dart';

final userLocalRepositoryProvider = StateProvider<UserLocalRepository>((ref) {
  return UserLocalRepository();
});

class UserLocalRepository {
  UserLocalRepository();

  User? getUserFromBox() {
    List<User> users = ObjectBoxHelper.usersBox.getAll();
    if (users.length > 1) throw Exception('More than one user found');
    return users.isNotEmpty ? users.first : null;
  }
}
