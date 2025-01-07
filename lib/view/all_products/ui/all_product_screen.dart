import 'package:ecommerce_app/utils/res/app_colors.dart';
import 'package:ecommerce_app/utils/common_utils.dart';
import 'package:ecommerce_app/utils/routes/app_pages.dart';
import 'package:ecommerce_app/view/all_products/ui/components/category_selection_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../all_products_bloc/all_products_bloc.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  TextEditingController searchCon = TextEditingController();

  String searchText = '';
  String selectedCategory = '';

  bool isFilterApplied = false;

  @override
  void initState() {
    super.initState();
    context.read<AllProductsBloc>().add(FetchProductEvent(isCategory: false, category: selectedCategory));
    context.read<AllProductsBloc>().add(FetchCategoryEvent());
  }

  @override
  void dispose() {
    super.dispose();
    context.read<AllProductsBloc>().close();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          shadowColor: AppColors.greyColor,
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: Text(
            'All Products',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              BlocConsumer<AllProductsBloc, AllProductsState>(
                buildWhen: (previous, current) => current is! AllProductActionState,
                listenWhen: (previous, current) => current is AllProductActionState,
                listener: (context, state) {
                  if (state is ShowCategoryDialogState) {
                    final blocContext = context; // Save the correct context
                    showModalBottomSheet(
                      context: context,
                      builder: (newContext) {
                        return CategorySelectionScreen(
                          category: state.category,
                          selected: selectedCategory,
                          onChanged: (value) {
                            isFilterApplied = true;
                            selectedCategory = value;
                            blocContext.read<AllProductsBloc>().add(
                                  FetchProductEvent(
                                    isCategory: true,
                                    category: selectedCategory,
                                  ),
                                );
                          },
                          onReset: (value) {
                            isFilterApplied = false;
                            blocContext.read<AllProductsBloc>().add(
                                  FetchProductEvent(
                                    isCategory: false,
                                    category: selectedCategory,
                                  ),
                                );
                          },
                        );
                      },
                    );
                  }
                },
                builder: (context, state) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding).copyWith(bottom: defaultPadding / 2),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 15,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: searchCon,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search_rounded),
                              hintText: 'Search..',
                              hintStyle: TextStyle(color: AppColors.lightGreyTextColor),
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.lightGrey),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(defaultRadius),
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.lightGrey),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(defaultRadius),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.lightGrey),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(defaultRadius),
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                searchText = value;
                              });
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.read<AllProductsBloc>().add(ShowBottomSheetEvent());
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.lightGrey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(defaultRadius),
                              ),
                              color: isFilterApplied ? Theme.of(context).primaryColor : Colors.transparent,
                            ),
                            child: Icon(
                              Icons.sort,
                              color: !isFilterApplied ? Theme.of(context).primaryColor : AppColors.whiteColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              Divider(),

              ///
              BlocBuilder<AllProductsBloc, AllProductsState>(
                buildWhen: (previous, current) => current != previous,
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case const (FetchProductLoadingState):
                      return Padding(
                        padding: const EdgeInsets.only(top: defaultPadding),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      );

                    ///
                    case const (FetchProductErrorState):
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
                    case const (FetchProductSuccessState):
                      state as FetchProductSuccessState;
                      return state.products.where((item) => item.title.toString().toLowerCase().contains(searchText.toLowerCase())).isEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: defaultPadding),
                              child: SizedBox(
                                child: Center(
                                  child: Text(
                                    'No product found...',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.all(defaultPadding).copyWith(top: defaultPadding / 2),
                                physics: RangeMaintainingScrollPhysics(),
                                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                itemCount: state.products.where((item) => item.title.toString().toLowerCase().contains(searchText.toLowerCase())).toList().length,
                                itemBuilder: (context, index) {
                                  var filteredProducts = state.products.where((item) => item.title.toString().toLowerCase().contains(searchText.toLowerCase())).toList();
                                  var item = filteredProducts[index];

                                  ///

                                  return InkWell(
                                    onTap: () {
                                      GoRouter.of(context).pushNamed(AppPages.productDetailPage, pathParameters: {
                                        'product_id': item.id.toString(),
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: defaultPadding / 1.5),
                                      padding: EdgeInsets.all(defaultPadding),
                                      decoration: BoxDecoration(
                                        color: AppColors.greyColor.withAlpha(20),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(defaultRadius),
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        spacing: 15,
                                        children: [
                                          Container(
                                            height: 110,
                                            width: 110,
                                            decoration: BoxDecoration(
                                              color: AppColors.greyColor.withAlpha(50),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(defaultRadius),
                                              ),
                                              image: DecorationImage(
                                                image: NetworkImage(item.image ?? ''),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: item.image == null
                                                ? Center(
                                                    child: Icon(
                                                      Icons.image_not_supported_rounded,
                                                      size: 25,
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.title.toString(),
                                                  maxLines: 2,
                                                  style: Theme.of(context).textTheme.titleMedium,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  item.description.toString(),
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
                                            '\$${item.price}',
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
            ],
          ),
        ),
      ),
    );
  }
}
