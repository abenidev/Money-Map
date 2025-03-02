import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_map/features/home/views/pages/overview_page.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setting',
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(),
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => OverviewPage()));
              },
              title: Text(
                'Overview',
                style: TextStyle(fontSize: 12.sp),
              ),
              trailing: Icon(Icons.arrow_forward_ios, size: 18.w),
            ),
          ],
        ),
      ),
    );
  }
}
