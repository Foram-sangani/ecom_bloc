import 'package:ecommerce_app/utils/common_utils.dart';
import 'package:ecommerce_app/view/all_products/product_details_bloc/product_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/res/app_colors.dart';

class ProductDetailScreen extends StatefulWidget {
  final int id;
  const ProductDetailScreen({super.key, required this.id});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductDetailBloc>().add(FetchProductDetailsEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: AppColors.greyColor,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          'Product Details',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w500,
              ),
        ),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (ProductDetailsLoadingState):
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );

            ///
            case const (ProductDetailFetchErrorState):
              return Center(
                child: Text(
                  'OOPS! Something went wrong..',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );

            ///
            case const (ProductDetailFetchSuccessState):
              state as ProductDetailFetchSuccessState;
              return Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: defaultPadding),
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(defaultRadius),
                          color: Colors.grey.shade200,
                          image: DecorationImage(
                            image: NetworkImage(state.product.image ?? ''),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding * 2,
                    ),

                    ///
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 20,
                      children: [
                        Expanded(
                          child: Text(
                            state.product.title.toString(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          '\$${state.product.price}',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: defaultPadding * 1.2,
                    ),

                    ///
                    Expanded(
                      child: Text(
                        state.product.description.toString(),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.lightGreyTextColor,
                            ),
                      ),
                    ),
                  ],
                ),
              );

            ///
            default:
              return Center(
                child: Text(
                  'Please wait..',
                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                ),
              );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Theme.of(context).primaryColor),
            shape: WidgetStatePropertyAll(
              ContinuousRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius)),
            ),
          ),
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: Text(
              'ADD TO CART',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
