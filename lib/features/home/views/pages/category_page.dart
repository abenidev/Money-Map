import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_map/core/models/category.dart';
import 'package:money_map/core/utils/app_utils.dart';
import 'package:money_map/core/widgets/custom_option_btn.dart';
import 'package:money_map/features/home/viewmodel/categories_viewmodel.dart';
import 'package:money_map/features/home/views/pages/category_add_page.dart';

class CategoryPage extends ConsumerStatefulWidget {
  const CategoryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends ConsumerState<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    List<Category> categories = ref.watch(categoriesViewmodelProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryAddPage())),
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(),
        child: Column(
          children: [
            sh(10),
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
                      // logger.i(selectedItems);
                      // Category selectedCat = selectedItems[0].data;
                      // ref.read(selectedCategoryProvider.notifier).state = selectedCat;
                    },
                  ),
                ).showModal(context);
              },
              child: Text('View Categories', style: TextStyle(fontSize: 12.sp)),
              // child: Text(
              // selectedCategory.name.capitalize,
              // style: TextStyle(fontSize: 12.sp),
              // ),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: categories.length,
            //     itemBuilder: (context, index) {
            //       Category category = categories[index];
            //       return ListTile(
            //         onTap: () {
            //           //
            //         },
            //         title: Text(
            //           category.name,
            //           style: TextStyle(fontSize: 12.sp),
            //         ),
            //       );
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
