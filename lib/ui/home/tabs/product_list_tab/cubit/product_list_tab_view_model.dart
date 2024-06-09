import 'package:e_commerce/domain/use_cases/get_all_products_use_case.dart';
import 'package:e_commerce/ui/home/tabs/product_list_tab/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/ProductResponseEntity.dart';
import '../../../../../domain/use_cases/add_cart_use_case.dart';

class ProductListTabViewModel extends Cubit<ProductListStates> {
  GetAllProductsUseCase getAllProductsUseCase;
  AddToCartUseCase addToCartUseCase;

  ProductListTabViewModel(
      {required this.getAllProductsUseCase, required this.addToCartUseCase})
      : super(ProductListInitialState());

  List<ProductEntity> productList = [];
  List<ProductEntity> filteredProductList = [];

  void getAllProducts() async {
    emit(ProductListLoadingState());
    var either = await getAllProductsUseCase.invoke();
    either.fold((l) => emit(ProductListErrorState(errors: l)), (response) {
      productList = response.data ?? [];
      filteredProductList = productList; // Initialize the filtered list
      emit(ProductListSuccessState(productResponseEntity: response));
    });
  }

  static ProductListTabViewModel getBloc(context) => BlocProvider.of(context);

  void filterProducts(String query) {
    if (query.isEmpty) {
      filteredProductList = productList;
    } else {
      filteredProductList = productList
          .where((product) =>
              product.title?.toLowerCase().contains(query.toLowerCase()) ??
              false)
          .toList();
    }
    emit(ProductListSuccessState(
        productResponseEntity:
            ProductResponseEntity(data: filteredProductList)));
  }

  void addToCart(String productId) async {
    emit(AddToCartLoadingState());
    var either = await addToCartUseCase.invoke(productId: productId);
    either.fold((l) => emit(AddToCartErrorState(errors: l)), (response) {
      emit(AddToCartSuccessState(addCartResponseEntity: response));
    });
  }
}
