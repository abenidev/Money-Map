import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_map/core/constants/app_enums/transaction_type.dart';
import 'package:money_map/core/models/category.dart';
import 'package:money_map/core/services/object_box_service.dart';
import 'package:money_map/objectbox.g.dart';

final categoriesLocalRepositoryProvider = StateProvider<CateogriesLocalRepository>((ref) {
  return CateogriesLocalRepository();
});

class CateogriesLocalRepository {
  CateogriesLocalRepository();

  List<Category> getAllCategories() {
    return ObjectBoxHelper.categoriesBox.getAll();
  }

  List<Category> getIncomeCategories() {
    Query<Category> builder = ObjectBoxHelper.categoriesBox.query(Category_.type.equals(TransactionType.income.name)).build();
    List<Category> categories = builder.find();
    builder.close();
    return categories;
  }

  List<Category> getExpenseCategories() {
    Query<Category> builder = ObjectBoxHelper.categoriesBox.query(Category_.type.equals(TransactionType.expense.name)).build();
    List<Category> categories = builder.find();
    builder.close();
    return categories;
  }

  void addCategory(Category category) {
    ObjectBoxHelper.categoriesBox.put(category);
  }

  Category getCategoryById(int id) {
    Category? category = ObjectBoxHelper.categoriesBox.get(id);
    if (category == null) throw Exception('Category not found');
    return category;
  }
}
