import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_notif_wrapper/local_notif_wrapper.dart';
import 'package:money_map/core/constants/app_strings.dart';
import 'package:money_map/core/services/firebase_messaging_service.dart';
import 'package:money_map/core/services/object_box_service.dart';
import 'package:money_map/features/home/views/pages/home_page.dart';
import 'package:money_map/features/onboarding/viewmodel/onboarding_viewmodel.dart';
import 'package:money_map/features/onboarding/views/pages/profile_setup_page.dart';
import 'package:money_map/features/onboarding/views/pages/welcome_page.dart';
import 'package:money_map/firebase_options.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:utils_wrapper/utils_wrapper.dart';

late ObjectBox objectbox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initialize();
  objectbox = await ObjectBox.create();

  //* Firebase config start -----------------------------------------------------
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Disable Firebase Analytics & Crashlytics in debug mode
  if (kDebugMode) {
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }
  if (kReleaseMode) {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
  //* Firebase config end -----------------------------------------------------

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: kAppName,
          debugShowCheckedModeBanner: false,
          theme: FlexColorScheme.light(scheme: FlexScheme.blumineBlue, useMaterial3: true, fontFamily: 'Poppins').toTheme,
          darkTheme: FlexColorScheme.dark(scheme: FlexScheme.blumineBlue, useMaterial3: true, fontFamily: 'Poppins').toTheme,
          themeMode: ThemeMode.system,
          home: Root(),
        );
      },
    );
  }
}

class Root extends ConsumerStatefulWidget {
  const Root({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RootState();
}

class _RootState extends ConsumerState<Root> with TickerProviderStateMixin {
  //Anim
  late AnimationController controller;
  Tween<double> tween = Tween(begin: 0.8, end: 1);

  @override
  void initState() {
    super.initState();
    //Anim
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    controller.repeat(reverse: true);

    afterBuildCreated(() {
      _init();
    });
  }

  _init() async {
    await UtilsWrapper.init(
      kAndroidAppPackageName: kAppAndroidPackageName,
      // kIosAppBundleId: "kIosBundleId",
      initUnityAds: false,
    );
    await LocalNotifWrapper.init();
    await FirebaseMessagingService.initNotifications();

    if (mounted) {
      if (!ref.read(onboardingViewmodelNotifierProvider.notifier).getIsWelcomeViewedVal()) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WelcomePage()));
        return;
      }
      if (!ref.read(onboardingViewmodelNotifierProvider.notifier).isUserSettedUp()) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfileSetupPage()));
        return;
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xff2D336B) : const Color(0xff2D336B),
      body: Container(
        decoration: const BoxDecoration(),
        child: Center(
          child: ScaleTransition(
            scale: tween.animate(CurvedAnimation(parent: controller, curve: Curves.ease)),
            child: Image(
              height: 100.h,
              width: 100.w,
              image: const AssetImage('assets/icon/icon_round.png'),
            ),
          ),
        ),
      ),
    );
  }
}
