import 'package:e_commerce/domain/use_cases/get_all_products_use_case.dart';
import 'package:e_commerce/ui/home/tabs/product_list_tab/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/ProductResponseEntity.dart';

class ProductListTabViewModel extends Cubit<ProductListStates> {
  GetAllProductsUseCase getAllProductsUseCase;

  ProductListTabViewModel({required this.getAllProductsUseCase})
      : super(ProductListInitialState());
  List<ProductEntity> productList = [];

  void getAllProducts() async {
    emit(ProductListLoadingState());
    var either = await getAllProductsUseCase.invoke();
    either.fold((l) => emit(ProductListErrorState(errors: l)), (response) {
      productList = response.data ?? [];
      emit(
        ProductListSuccessState(productResponseEntity: response),
      );
    });
  }
}
