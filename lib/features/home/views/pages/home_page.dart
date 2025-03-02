import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_map/core/models/user.dart';
import 'package:money_map/core/utils/app_utils.dart';
import 'package:money_map/features/home/viewmodel/home_viewmodel.dart';
import 'package:nb_utils/nb_utils.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      ref.read(homeViewModelProvider.notifier).updateUserStateFromBox();
    });
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
            icon: Icon(Icons.settings, size: 22.w),
          ),
        ],
      ),
      body: Center(
        child: Text('${currentUser.accounts.first.balance}'),
      ),
    );
  }
}
