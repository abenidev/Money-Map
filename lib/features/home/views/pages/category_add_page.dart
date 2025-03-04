import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_map/core/constants/app_enums/transaction_type.dart';
import 'package:money_map/core/models/category.dart';
import 'package:money_map/core/utils/app_utils.dart';
import 'package:money_map/core/widgets/custom_elevated_btn.dart';
import 'package:money_map/core/widgets/custom_option_btn.dart';
import 'package:money_map/features/home/viewmodel/categories_viewmodel.dart';
import 'package:money_map/main.dart';

final selectedCategoryTypeProvider = StateProvider<TransactionType>((ref) {
  return TransactionType.expense;
});

class CategoryAddPage extends ConsumerStatefulWidget {
  const CategoryAddPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryAddPageState();
}

class _CategoryAddPageState extends ConsumerState<CategoryAddPage> {
  late TextEditingController textEditingController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TransactionType selectedCategoryType = ref.watch(selectedCategoryTypeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Category',
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: const BoxDecoration(),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sh(10),
              CustomOptionBtn(
                onTap: () {
                  DropDownState<String>(
                    dropDown: DropDown(
                      // data: categories.map((category) => SelectedListItem<Category>(data: category)).toList(),
                      data: [
                        SelectedListItem<String>(data: TransactionType.expense.name),
                        SelectedListItem<String>(data: TransactionType.income.name),
                      ],
                      listItemBuilder: (index, dataItem) {
                        return ListTile(
                          title: Text(
                            dataItem.data,
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        );
                      },
                      onSelected: (selectedItems) {
                        logger.i(selectedItems);
                        String selectedCatType = selectedItems[0].data;
                        ref.read(selectedCategoryTypeProvider.notifier).state = selectedCatType.toTransactionType;
                      },
                    ),
                  ).showModal(context);
                },
                child: Text(
                  selectedCategoryType.name.capitalize,
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
              sh(10),
              Text('Name', style: TextStyle(fontSize: 12.sp)),
              sh(5),
              TextFormField(
                controller: textEditingController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              sh(10),
              CustomElevatedBtn(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Category category = Category(name: textEditingController.text.trim(), type: selectedCategoryType.name);
                    ref.read(categoriesViewmodelProvider.notifier).addCategory(category);
                    Navigator.pop(context);
                  }
                },
                title: 'Add',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
