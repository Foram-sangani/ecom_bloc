import 'package:ecommerce_app/view/all_products/product_details_bloc/product_detail_bloc.dart';
import 'package:ecommerce_app/view/all_products/ui/widgets/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart' show GoRoute, GoRouter, GoRouterHelper;

import '../../Utils/routes/app_pages.dart';
import '../../view/all_products/all_products_bloc/all_products_bloc.dart';
import '../../view/all_products/ui/all_product_screen.dart';

class AppRoutes {
  static GoRouter returnRouter(bool isAuth) {
    GoRouter router = GoRouter(
      initialLocation: '/all_product',
      debugLogDiagnostics: true,
      routes: [
        ///
        GoRoute(
          name: AppPages.allProductsPage,
          path: '/all_product',
          builder: (context, state) {
            return BlocProvider(
              create: (_) => AllProductsBloc(),
              child: const AllProductScreen(),
            );
          },
        ),

        ///
        GoRoute(
          name: AppPages.productDetailPage,
          path: '/product_detail/:product_id',
          builder: (context, state) {
            return BlocProvider(
              create: (_) => ProductDetailBloc(),
              child: ProductDetailScreen(
                id: int.parse(state.pathParameters['product_id']!),
              ),
            );
          },
        ),
      ],

      /// Authentication
      redirect: (context, state) {
        if (!isAuth) {
          return context.namedLocation(AppPages.allProductsPage);
        } else {
          return null;
        }
      },
    );
    return router;
  }
}
