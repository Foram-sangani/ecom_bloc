part of 'product_detail_bloc.dart';

@immutable
sealed class ProductDetailEvent {}

class FetchProductDetailsEvent extends ProductDetailEvent {
  final int id;

  FetchProductDetailsEvent({required this.id});
}

class AddToCartEvent extends ProductDetailEvent {
  final Map<String, dynamic> cartData;

  AddToCartEvent({required this.cartData});
}
