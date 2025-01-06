import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/utils/color_print.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../utils/model/product_model.dart';

part 'all_products_event.dart';
part 'all_products_state.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  List<ProductsModel> products = [];
  List category = [];

  AllProductsBloc() : super(AllProductsInitial()) {
    on<AllProductsEvent>((event, emit) {});
    on<FetchProductEvent>(fetchProductEvent);
    on<ShowDialogEvent>(showDialogEvent);
    on<FetchCategoryEvent>(fetchCategoryEvent);
  }

  Future<void> showDialogEvent(ShowDialogEvent event, Emitter<AllProductsState> emit) async {
    emit(ShowCategoryDialogState(category: category));
    emit(FetchProductSuccessState(products: products));
  }

  Future<void> fetchProductEvent(FetchProductEvent event, Emitter<AllProductsState> emit) async {
    emit(FetchProductLoadingState());
    try {
      var client = http.Client();
      var response = await client.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        List result = jsonDecode(response.body);

        for (int i = 0; i < result.length; i++) {
          ProductsModel productsModel = ProductsModel.fromJson(result[i]);
          products.add(productsModel);
        }

        emit(FetchProductSuccessState(products: products));
      } else {
        printOkStatus(response.body);
        emit(FetchProductErrorState());
      }
    } catch (e) {
      printOkStatus(e.toString());
      emit(FetchProductErrorState());
    }
  }

  Future<void> fetchCategoryEvent(FetchCategoryEvent event, Emitter<AllProductsState> emit) async {
    try {
      var client = http.Client();
      var response = await client.get(
        Uri.parse('https://fakestoreapi.com/products/categories'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {

        List result = jsonDecode(response.body);

        category.addAll(result);

      } else {
        printOkStatus(response.body);
      }
    } catch (e) {
      printOkStatus(e.toString());
    }
  }
}
