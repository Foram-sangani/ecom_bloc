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
              return Expanded(
                child: ListView.separated(
                  itemCount: 5,
                  physics: RangeMaintainingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: SizedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 15,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: AppColors.greyColor.withAlpha(50),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(defaultRadius),
                                ),
                                // image: DecorationImage(
                                //   image: NetworkImage(item.image ?? ''),
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              child: /* item.image == null
                              ? Center(
                                  child: Icon(
                                    Icons.image_not_supported_rounded,
                                    size: 25,
                                  ),
                                )
                              :*/
                                  SizedBox.shrink(),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'item.title.toString()',
                                    maxLines: 2,
                                    style: Theme.of(context).textTheme.titleMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'item.description.toString()',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          color: AppColors.lightGreyTextColor,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '\${item.price}',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
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
