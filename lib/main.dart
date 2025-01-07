import 'package:ecommerce_app/utils/local_storage.dart';
import 'package:ecommerce_app/utils/res/app_colors.dart';
import 'package:ecommerce_app/utils/res/app_theme.dart';
import 'package:ecommerce_app/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await LocalStorage.readDataInfo();
  final GoRouter router = AppRoutes.returnRouter(true);
  runApp(MyApp(
    router: router,
  ));
}

class MyApp extends StatelessWidget {
  final GoRouter? router;
  const MyApp({super.key, this.router});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: AppTheme.lightMode(context, kPrimaryColor: AppColors.kPrimaryColor, errorColor: AppColors.error, fontFamily: AppTheme.fontFamilyInter),
          darkTheme: AppTheme.darkMode(context, kPrimaryColor: AppColors.kPrimaryColor, errorColor: AppColors.error, fontFamily: AppTheme.fontFamilyInter),
          routeInformationParser: router?.routeInformationParser,
          routerDelegate: router?.routerDelegate,
          routeInformationProvider: router?.routeInformationProvider,
        );
      },
    );
  }
}
