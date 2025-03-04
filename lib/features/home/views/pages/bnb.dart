import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_map/core/models/user.dart';
import 'package:money_map/core/utils/app_utils.dart';
import 'package:money_map/features/home/viewmodel/account_viewmodel.dart';
import 'package:money_map/features/home/viewmodel/categories_viewmodel.dart';
import 'package:money_map/features/home/viewmodel/home_viewmodel.dart';
import 'package:money_map/features/home/viewmodel/transaction_viewmodel.dart';
import 'package:money_map/features/home/views/pages/category_page.dart';
import 'package:money_map/features/home/views/pages/home_page.dart';
import 'package:money_map/features/home/views/pages/setting_page.dart';
import 'package:nb_utils/nb_utils.dart';

class Bnb extends ConsumerStatefulWidget {
  const Bnb({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BnbState();
}

class _BnbState extends ConsumerState<Bnb> {
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      ref.read(homeViewModelProvider.notifier).updateUserStateFromBox();
      ref.read(transactionViewmodelProvider.notifier).updateCurrentMonthTransactionsListState();
      ref.read(categoriesViewmodelProvider.notifier).updateCategoriesState();
      ref.read(accountViewmodelProvider.notifier).updateAccountsState();
    });
  }

  int selectedIndex = 0;
  List<Widget> pages = [
    HomePage(),
    CategoryPage(),
    Center(child: Text('Profile Screen', style: TextStyle(fontSize: 24))),
  ];
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    User? currentUser = ref.watch(homeViewModelProvider);

    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error, user cannot be null!'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          getFormatedDate(now, format: 'EEEE, MMM d'),
          style: TextStyle(fontSize: 16.sp),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage()));
            },
            icon: Icon(Icons.settings, size: 22.w),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.blue, // Active tab color
        unselectedItemColor: Colors.grey, // Inactive tab color
        showUnselectedLabels: true, // Show labels for inactive tabs
      ),
      body: pages[selectedIndex],
    );
  }
}
