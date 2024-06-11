import 'package:e_commerce/domain/di.dart';
import 'package:e_commerce/ui/home/tabs/product_list_tab/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/my_assets.dart';
import '../../product_details/product_details_view.dart';
import '../home_tab/widgets/custom_search_with_shopping_cart.dart';
import 'cubit/product_list_tab_view_model.dart';
import 'widgets/grid_view_card_item.dart';

class ProductListTab extends StatefulWidget {
  const ProductListTab({super.key});

  @override
  _ProductListTabState createState() => _ProductListTabState();
}

class _ProductListTabState extends State<ProductListTab> {
  ProductListTabViewModel viewModel = ProductListTabViewModel(
      getAllProductsUseCase: injectGetAllProductsUseCase(),
      addToCartUseCase: injectAddToCartUseCase());

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.getAllProducts();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    viewModel.filterProducts(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductListTabViewModel>(
      create: (context) => viewModel,
      child: BlocBuilder<ProductListTabViewModel, ProductListStates>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      width: 150,
                      MyAssets.logo,
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  CustomSearchWithShoppingCart(
                    searchController: _searchController,
                    onSearchChanged: (value) => _onSearchChanged(),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  state is ProductListLoadingState
                      ? Padding(
                          padding: const EdgeInsets.only(top: 150),
                          child: Center(
                            child: Lottie.asset(
                                'assets/animations/loading.json',
                                width: 150),
                          ),
                        )
                      : Expanded(
                          child: GridView.builder(
                            itemCount: viewModel.filteredProductList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2 / 2.4,
                                    crossAxisSpacing: 16.w,
                                    mainAxisSpacing: 16.h),
                            itemBuilder: (context, index) {
                              return InkWell(
                                splashColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      ProductDetailsView.routeName,
                                      arguments: {
                                        'product': viewModel
                                            .filteredProductList[index],
                                        'productList':
                                            viewModel.filteredProductList,
                                        'onAddToCart': () {
                                          viewModel.addToCart(viewModel
                                                  .filteredProductList[index]
                                                  .id ??
                                              '');
                                        }
                                      });
                                },
                                child: GridViewCardItem(
                                  productEntity:
                                      viewModel.filteredProductList[index],
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
