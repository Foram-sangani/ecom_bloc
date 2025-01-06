part of 'all_products_bloc.dart';

@immutable
sealed class AllProductsEvent {}

class FetchProductEvent extends AllProductsEvent {}

class FetchCategoryEvent extends AllProductsEvent {}

class ShowDialogEvent extends AllProductsEvent {}
