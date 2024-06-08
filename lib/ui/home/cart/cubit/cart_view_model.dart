import 'package:e_commerce/domain/entities/GetCartResponseEntity.dart';
import 'package:e_commerce/ui/home/cart/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/use_cases/delete_item_in_cart_use_case.dart';
import '../../../../domain/use_cases/get_cart_use_case.dart';
import '../../../../domain/use_cases/update_count_item_use_case.dart';

class CartViewModel extends Cubit<CartStates> {
  GetCartUseCase getCartUseCase;
  DeleteItemInCartUseCase deleteItemInCartUseCase;
  UpdateItemInCartUseCase updateItemInCartUseCase;

  CartViewModel(
      {required this.getCartUseCase,
      required this.deleteItemInCartUseCase,
      required this.updateItemInCartUseCase})
      : super(CartInitState());
  List<GetProductsEntity> cartItemsList = [];

  static CartViewModel get(context) => BlocProvider.of(context);

  void getCartItems() async {
    emit(CartLoadingState());
    var either = await getCartUseCase.invoke();
    either.fold((l) {
      emit(CartErrorState(errors: l));
    }, (response) {
      cartItemsList = response.data!.products ?? [];
      emit(CartSuccessState(cartResponseEntity: response));
    });
  }

  void deleteItemInCart(String productId) async {
    emit(DeleteItemInCartLoadingState());
    var either = await deleteItemInCartUseCase.invoke(productId);
    either.fold((l) {
      emit(DeleteItemInCartErrorState(errors: l));
    }, (response) {
      cartItemsList = response.data!.products ?? [];
      emit(CartSuccessState(cartResponseEntity: response));
    });
  }

  void updateItemCount(String productId, int count) async {
    emit(UpdateItemCountLoadingState());
    var either = await updateItemInCartUseCase.invoke(productId, count);
    either.fold((l) {
      emit(UpdateItemCountErrorState(errors: l));
    }, (response) {
      cartItemsList = response.data!.products ?? [];
      emit(CartSuccessState(cartResponseEntity: response));
    });
  }
}
