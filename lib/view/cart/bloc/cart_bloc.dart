import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/utils/color_print.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List cartProducts = [];

  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) {});
    on<FetchCartProductsEvent>(fetchCartProducts);
  }

  Future<void> fetchCartProducts(FetchCartProductsEvent event, Emitter<CartState> emit) async {
    emit(FetchCartProductLoadingState());
    try {
      cartProducts.clear();

      var client = http.Client();
      var response = await client.get(
        Uri.parse('https://fakestoreapi.com/carts'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        List result = jsonDecode(response.body);

        printOkStatus(response.body);

        for (int i = 0; i < result.length; i++) {
          // ProductsModel productsModel = ProductsModel.fromJson(result[i]);
          // products.add(productsModel);
        }

        emit(FetchCartProductSuccessState(cart: cartProducts));
      } else {
        printOkStatus(response.body);
        emit(FetchCartProductErrorState());
      }
    } catch (e) {
      printOkStatus(e.toString());
      emit(FetchCartProductErrorState());
    }
  }
}
