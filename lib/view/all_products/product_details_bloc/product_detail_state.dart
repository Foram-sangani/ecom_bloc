part of 'product_detail_bloc.dart';

@immutable
sealed class ProductDetailState {}

final class ProductDetailInitial extends ProductDetailState {}

abstract class ProductDetailActionState extends ProductDetailState {}

class ProductDetailsLoadingState extends ProductDetailState {}

class ProductDetailFetchSuccessState extends ProductDetailState {
  final ProductsModel product;

  ProductDetailFetchSuccessState({required this.product});
}

class ProductDetailFetchErrorState extends ProductDetailState {}

class AddToCartLoadingState extends ProductDetailActionState {}

class AddToCartSuccessState extends ProductDetailActionState {}
