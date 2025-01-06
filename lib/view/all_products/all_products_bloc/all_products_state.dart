part of 'all_products_bloc.dart';

@immutable
sealed class AllProductsState {}

final class AllProductsInitial extends AllProductsState {}

abstract class AllProductActionState extends AllProductsState {}

class FetchProductSuccessState extends AllProductsState {
  final List<ProductsModel> products;

  FetchProductSuccessState({required this.products});
}

class FetchProductLoadingState extends AllProductsState {}

class FetchProductErrorState extends AllProductsState {}

class ShowCategoryDialogState extends AllProductActionState {
  final List category;

  ShowCategoryDialogState({required this.category});
}
