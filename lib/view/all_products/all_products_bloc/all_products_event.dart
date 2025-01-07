part of 'all_products_bloc.dart';

@immutable
sealed class AllProductsEvent {}

class FetchProductEvent extends AllProductsEvent {
  final bool isCategory;
  final String category;

  FetchProductEvent({required this.isCategory, required this.category});
}

class FetchCategoryEvent extends AllProductsEvent {}

class ShowBottomSheetEvent extends AllProductsEvent {}
