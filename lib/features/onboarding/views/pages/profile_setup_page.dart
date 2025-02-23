import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_map/core/utils/app_utils.dart';
import 'package:money_map/core/widgets/custom_elevated_btn.dart';
import 'package:money_map/core/widgets/custom_option_btn.dart';

class ProfileSetupPage extends ConsumerStatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends ConsumerState<ProfileSetupPage> {
  @override
  Widget build(BuildContext context) {
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
                      SelectedListItem<String>(data: 'Tokyo'),
                      SelectedListItem<String>(data: 'New York'),
                      SelectedListItem<String>(data: 'London'),
                    ],
                    onSelected: (selectedItems) {
                      List<String> list = [];
                      for (var item in selectedItems) {
                        list.add(item.data);
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            list.toString(),
                          ),
                        ),
                      );
                    },
                  ),
                ).showModal(context);
              },
              child: Text(
                'ETB (Ethiopian Birr)',
                style: TextStyle(fontSize: 12.sp),
              ),
            ),
            sh(15),
            Text('Income Source', style: TextStyle(fontSize: 12.sp)),
            sh(10),
            CustomOptionBtn(
              onTap: () {},
              child: Center(
                child: Text(
                  '+',
                  style: TextStyle(fontSize: 22.sp),
                ),
              ),
            ),
            sh(15),
            Text('Budget Cycle', style: TextStyle(fontSize: 12.sp)),
            sh(10),
            CustomOptionBtn(
              onTap: () {},
              child: Text(
                'Monthly',
                style: TextStyle(fontSize: 12.sp),
              ),
            ),
            Spacer(),
            CustomElevatedBtn(
              onTap: () {
                //
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
