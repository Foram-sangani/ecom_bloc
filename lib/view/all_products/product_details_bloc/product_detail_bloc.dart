import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../../../utils/color_print.dart';
import '../../../utils/model/product_model.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitial()) {
    on<ProductDetailEvent>((event, emit) {});
    on<FetchProductDetailsEvent>(fetchProductDetailsEvent);
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
        ProductsModel productsModel = ProductsModel.fromJson(result);

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
}
