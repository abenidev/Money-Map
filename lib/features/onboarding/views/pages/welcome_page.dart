import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:money_map/core/constants/app_strings.dart';
import 'package:money_map/core/utils/app_utils.dart';
import 'package:money_map/core/widgets/custom_elevated_btn.dart';
import 'package:money_map/features/onboarding/viewmodel/onboarding_viewmodel.dart';
import 'package:money_map/features/onboarding/views/pages/profile_setup_page.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          width: double.infinity,
          child: Column(
            children: [
              sh(10),
              Text(
                kAppName,
                style: TextStyle(fontSize: 28.sp, fontFamily: "Madimi"),
              ),
              Lottie.asset('assets/anims/welcome.json', height: 400.h, width: 300.w),
              sh(5),
              Text(
                "Track Expenses, Plan Budgets, Achieve Goals",
                style: TextStyle(fontSize: 24.sp),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              CustomElevatedBtn(
                onTap: () {
                  ref.read(onboardingViewmodelNotifierProvider.notifier).setIsWelcomeViewedVal(true);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileSetupPage()));
                },
                title: 'Get Started',
              ),
              sh(10),
            ],
          ),
        ),
      ),
    );
  }
}
