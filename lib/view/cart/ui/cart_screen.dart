import 'package:ecommerce_app/view/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/common_utils.dart';
import '../../../utils/res/app_colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(FetchCartProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: AppColors.greyColor,
        backgroundColor: Theme.of(context).primaryColor,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.whiteColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Text(
              'Products',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.greyColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),

          ///
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case FetchCartProductLoadingState:
                  return Expanded(
                    child: SizedBox(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );

                case FetchCartProductErrorState:
                  return Expanded(
                    child: SizedBox(
                      child: Center(
                        child: Text(
                          'OOPS! Something went wrong..',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );

                case FetchCartProductSuccessState:
                  state as FetchCartProductSuccessState;
                  return Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.only(bottom: defaultPadding),
                      itemCount: state.cart.length,
                      physics: RangeMaintainingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var item = state.cart[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                          child: SizedBox(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 15,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Product id : ${item.productId}',
                                        maxLines: 2,
                                        style: Theme.of(context).textTheme.titleMedium,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Quantity : ${item.quantity}',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                              color: AppColors.lightGreyTextColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                    ),
                  );

                ///
                default:
                  return Center(
                    child: Text(
                      'Product not found...',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
              }
            },
          ),

          ///

          Container(
            padding: EdgeInsets.all(defaultPadding),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding),
            decoration: BoxDecoration(
              color: AppColors.greyColor.withAlpha(10),
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.lightGreyTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      '\$4500',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppColors.lightGreyTextColor,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.lightGreyTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      '\$200',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppColors.lightGreyTextColor,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shipping',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.lightGreyTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      '\$120',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppColors.lightGreyTextColor,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 18.sp,
                            color: AppColors.lightGreyTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      '\$4420',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.lightGreyTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),

      ///
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
              'BUY NOW',
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
