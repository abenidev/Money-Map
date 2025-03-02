import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_map/core/constants/app_enums/budget_cycle.dart';
import 'package:money_map/core/constants/app_enums/currency_type.dart';
import 'package:money_map/core/models/user.dart';
import 'package:money_map/core/utils/app_utils.dart';
import 'package:money_map/core/widgets/custom_elevated_btn.dart';
import 'package:money_map/core/widgets/custom_option_btn.dart';
import 'package:money_map/features/home/views/pages/home_page.dart';
import 'package:money_map/features/onboarding/viewmodel/onboarding_viewmodel.dart';

final selectedCurrencyProvider = StateProvider<String>((ref) {
  return CurrencyType.etb.name;
});

final selectedBudgetCycleProvider = StateProvider<String>((ref) {
  return BudgetCycle.monthly.name;
});

class ProfileSetupPage extends ConsumerStatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends ConsumerState<ProfileSetupPage> {
  @override
  Widget build(BuildContext context) {
    String selectedCurrency = ref.watch(selectedCurrencyProvider);
    String selectedBudgetCycle = ref.watch(selectedBudgetCycleProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Setup',
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sh(10),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50.w,
                    child: Icon(Icons.person_outline, size: 40.w),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          //TODO:
                        },
                        icon: Icon(Icons.edit, size: 18.w),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            sh(15),
            Text('Currency', style: TextStyle(fontSize: 12.sp)),
            sh(10),
            CustomOptionBtn(
              onTap: () {
                DropDownState<String>(
                  dropDown: DropDown<String>(
                    data: <SelectedListItem<String>>[
                      SelectedListItem<String>(data: CurrencyType.etb.name),
                      SelectedListItem<String>(data: CurrencyType.usd.name),
                    ],
                    onSelected: (selectedItems) {
                      String selectedVal = selectedItems[0].data.toString();
                      ref.read(selectedCurrencyProvider.notifier).state = selectedVal;
                    },
                  ),
                ).showModal(context);
              },
              child: Text(
                selectedCurrency,
                style: TextStyle(fontSize: 12.sp),
              ),
            ),
            sh(15),
            Text('Budget Cycle', style: TextStyle(fontSize: 12.sp)),
            sh(10),
            CustomOptionBtn(
              onTap: () {
                DropDownState<String>(
                  dropDown: DropDown<String>(
                    data: [
                      SelectedListItem<String>(data: BudgetCycle.monthly.name),
                      SelectedListItem<String>(data: BudgetCycle.weekly.name),
                    ],
                    onSelected: (selectedItems) {
                      String selectedVal = selectedItems[0].data.toString();
                      ref.read(selectedBudgetCycleProvider.notifier).state = selectedVal;
                    },
                  ),
                ).showModal(context);
              },
              child: Text(
                selectedBudgetCycle,
                style: TextStyle(fontSize: 12.sp),
              ),
            ),
            // sh(15),
            // Text('Income Source', style: TextStyle(fontSize: 12.sp)),
            // sh(10),
            // CustomOptionBtn(
            //   onTap: () {},
            //   child: Center(
            //     child: Text(
            //       '+',
            //       style: TextStyle(fontSize: 22.sp),
            //     ),
            //   ),
            // ),
            Spacer(),
            CustomElevatedBtn(
              onTap: () {
                User newUser = User(
                  name: '',
                  currency: selectedCurrency,
                  profilePic: '',
                  budgetCycle: selectedBudgetCycle,
                );
                ref.read(onboardingViewmodelNotifierProvider.notifier).addNewUserToBox(newUser, loadDefaultCategories: true);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
              title: 'Continue',
            ),
            sh(20),
          ],
        ),
      ),
    );
  }
}
