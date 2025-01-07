import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/utils/color_print.dart';
import 'package:ecommerce_app/utils/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<CartProduct> cartProducts = [];

  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) {});
    on<FetchCartProductsEvent>(fetchCartProducts);
  }

  Future<void> fetchCartProducts(FetchCartProductsEvent event, Emitter<CartState> emit) async {
    emit(FetchCartProductLoadingState());
    cartProducts.clear();

    var client = http.Client();
    try {
      var response = await client.get(
        Uri.parse('https://fakestoreapi.com/carts'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Decode the response and map it to a list of CartModel
        List<dynamic> decodedJson = jsonDecode(response.body);
        List<CartModel> result = decodedJson.map((e) => CartModel.fromJson(e as Map<String, dynamic>)).toList();

        printOkStatus(response.body);

        cartProducts.addAll(result.expand((cart) => cart.products ?? []));

        emit(FetchCartProductSuccessState(cart: cartProducts));
      } else {
        printOkStatus(response.body);
        emit(FetchCartProductErrorState());
      }
    } catch (e) {
      printOkStatus(e.toString());
      emit(FetchCartProductErrorState());
    } finally {
      client.close();
    }
  }
}
