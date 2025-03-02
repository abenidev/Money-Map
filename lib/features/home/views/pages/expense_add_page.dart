import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_map/core/constants/app_enums/transaction_type.dart';
import 'package:money_map/core/models/account.dart';
import 'package:money_map/core/models/category.dart';
import 'package:money_map/core/utils/app_utils.dart';
import 'package:money_map/core/widgets/custom_option_btn.dart';
import 'package:money_map/features/home/viewmodel/account_viewmodel.dart';
import 'package:money_map/features/home/viewmodel/categories_viewmodel.dart';
import 'package:money_map/features/home/viewmodel/transaction_viewmodel.dart';
import 'package:money_map/features/home/views/pages/income_add_page.dart';
import 'package:money_map/main.dart';
import 'package:nb_utils/nb_utils.dart';

class ExpenseAddPage extends ConsumerStatefulWidget {
  const ExpenseAddPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExpenseAddPageState();
}

class _ExpenseAddPageState extends ConsumerState<ExpenseAddPage> {
  late TextEditingController _amountController;
  late TextEditingController _descriptionController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String currencySymbol = 'Br. ';

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _descriptionController = TextEditingController();
    afterBuildCreated(() {
      Account defaultAccount = ref.read(accountViewmodelProvider.notifier).getDefaultAccount();
      ref.read(selectedAccountProvider.notifier).state = defaultAccount;
      List<Category> expenseCategories = ref.read(categoriesViewmodelProvider.notifier).getExpenseCategories();
      if (expenseCategories.isEmpty) throw Exception('Categories cannot be empty at this state!');
      ref.read(selectedCategoryProvider.notifier).state = expenseCategories[0];
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Category> categories = ref.watch(categoriesViewmodelProvider.notifier).getExpenseCategories();
    List<Account> accounts = ref.watch(accountViewmodelProvider);
    Account? selectedAccount = ref.watch(selectedAccountProvider);
    Category? selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Expense',
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
      body: selectedAccount == null || selectedCategory == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: const BoxDecoration(),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sh(10),
                    Text('Account', style: TextStyle(fontSize: 12.sp)),
                    sh(5),
                    CustomOptionBtn(
                      onTap: () {
                        DropDownState<Account>(
                          dropDown: DropDown(
                            data: accounts.map((account) => SelectedListItem<Account>(data: account)).toList(),
                            listItemBuilder: (index, dataItem) {
                              return ListTile(
                                title: Text(
                                  dataItem.data.name,
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                              );
                            },
                            onSelected: (selectedItems) {
                              logger.i(selectedItems);
                              Account selectedAcc = selectedItems[0].data;
                              ref.read(selectedAccountProvider.notifier).state = selectedAcc;
                            },
                          ),
                        ).showModal(context);
                      },
                      child: Text(
                        selectedAccount.name.capitalize,
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ),
                    sh(10),
                    Text('Category', style: TextStyle(fontSize: 12.sp)),
                    sh(5),
                    CustomOptionBtn(
                      onTap: () {
                        DropDownState<Category>(
                          dropDown: DropDown(
                            data: categories.map((category) => SelectedListItem<Category>(data: category)).toList(),
                            listItemBuilder: (index, dataItem) {
                              return ListTile(
                                title: Text(
                                  dataItem.data.name,
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                              );
                            },
                            onSelected: (selectedItems) {
                              logger.i(selectedItems);
                              Category selectedCat = selectedItems[0].data;
                              ref.read(selectedCategoryProvider.notifier).state = selectedCat;
                            },
                          ),
                        ).showModal(context);
                      },
                      child: Text(
                        selectedCategory.name.capitalize,
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ),
                    sh(10),
                    Text('Amount', style: TextStyle(fontSize: 12.sp)),
                    sh(5),
                    TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 12.sp),
                      inputFormatters: [
                        CurrencyTextInputFormatter.currency(
                          symbol: currencySymbol,
                        ),
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Br. 10.00',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Amount cannot be empty";
                        }
                        return null;
                      },
                    ),
                    sh(10),
                    Text('Description (optional)', style: TextStyle(fontSize: 12.sp)),
                    sh(5),
                    TextFormField(
                      controller: _descriptionController,
                      keyboardType: TextInputType.text,
                      maxLines: 4,
                      maxLength: 150,
                      style: TextStyle(fontSize: 12.sp),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    sh(20),
                    SizedBox(
                      width: double.infinity,
                      height: 40.h,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            try {
                              double enteredAmount = double.parse(_amountController.text.trim().replaceAll(currencySymbol, '').replaceAll(',', ''));
                              String desc = _descriptionController.text.trim();
                              logger.i(enteredAmount);
                              ref.read(transactionViewmodelProvider.notifier).addTransaction(
                                    enteredAmount,
                                    desc,
                                    TransactionType.expense,
                                    selectedCategory,
                                    selectedAccount,
                                  );
                              Navigator.pop(context);
                            } catch (e) {
                              logger.e(e);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.w),
                          ),
                        ),
                        child: Text('Add Transaction', style: TextStyle(fontSize: 12.sp)),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
