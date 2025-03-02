import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_map/core/models/category.dart';
import 'package:money_map/features/home/repositories/cateogries_local_repository.dart';

final categoriesViewmodelProvider = StateNotifierProvider<CategoriesViewmodelNotifier, List<Category>>((ref) {
  final cateogriesLocalRepository = ref.watch(categoriesLocalRepositoryProvider);
  return CategoriesViewmodelNotifier(
    cateogriesLocalRepository: cateogriesLocalRepository,
  );
});

class CategoriesViewmodelNotifier extends StateNotifier<List<Category>> {
  CateogriesLocalRepository cateogriesLocalRepository;
  CategoriesViewmodelNotifier({
    required this.cateogriesLocalRepository,
  }) : super([]);

  void updateCategoriesState() {
    state = getAllCategories();
  }

  List<Category> getAllCategories() {
    return cateogriesLocalRepository.getAllCategories();
  }

  List<Category> getIncomeCategories() {
    return cateogriesLocalRepository.getIncomeCategories();
  }

  List<Category> getExpenseCategories() {
    return cateogriesLocalRepository.getExpenseCategories();
  }
}
