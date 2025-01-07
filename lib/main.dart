import 'package:ecommerce_app/utils/local_storage.dart';
import 'package:ecommerce_app/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routeInformationParser: router?.routeInformationParser,
      routerDelegate: router?.routerDelegate,
      routeInformationProvider: router?.routeInformationProvider,
    );
  }
}
