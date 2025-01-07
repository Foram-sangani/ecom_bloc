part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class FetchedCartProducts extends CartState {}

class FetchCartProductSuccessState extends CartState {
  final List<CartProduct> cart;

  FetchCartProductSuccessState({required this.cart});
}

class FetchCartProductLoadingState extends CartState {}

class FetchCartProductErrorState extends CartState {}
