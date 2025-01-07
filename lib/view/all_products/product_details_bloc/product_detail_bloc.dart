import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../../../utils/color_print.dart';
import '../../../utils/model/product_model.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductsModel productsModel = ProductsModel();

  ProductDetailBloc() : super(ProductDetailInitial()) {
    on<ProductDetailEvent>((event, emit) {});
    on<FetchProductDetailsEvent>(fetchProductDetailsEvent);
    on<AddToCartEvent>(addToCartEvent);
  }

  Future<void> fetchProductDetailsEvent(FetchProductDetailsEvent event, Emitter<ProductDetailState> emit) async {
    emit(ProductDetailsLoadingState());

    try {
      var client = http.Client();
      var response = await client.get(
        Uri.parse('https://fakestoreapi.com/products/${event.id}'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> result = jsonDecode(response.body);
        printOkStatus(result);
        productsModel = ProductsModel.fromJson(result);

        emit(ProductDetailFetchSuccessState(product: productsModel));
      } else {
        printOkStatus(response.body);
        emit(ProductDetailFetchErrorState());
      }
    } catch (e) {
      printOkStatus(e.toString());
      emit(ProductDetailFetchErrorState());
    }
  }

  Future<void> addToCartEvent(AddToCartEvent event, Emitter<ProductDetailState> emit) async {
    emit(AddToCartLoadingState());
    emit(ProductDetailFetchSuccessState(product: productsModel));

    try {
      var client = http.Client();
      var response = await client.post(
        Uri.parse('https://fakestoreapi.com/carts'),
        body: jsonEncode(event.cartData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        printOkStatus(response.body);
        emit(AddToCartSuccessState());
        emit(ProductDetailFetchSuccessState(product: productsModel));
      } else {
        printOkStatus(response.body);
      }
    } catch (e) {
      printOkStatus(e.toString());
    }
  }
}
