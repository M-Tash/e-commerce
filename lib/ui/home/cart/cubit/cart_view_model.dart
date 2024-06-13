import 'package:e_commerce/domain/entities/GetCartResponseEntity.dart';
import 'package:e_commerce/ui/home/cart/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/use_cases/check_out_Items_use_case.dart';
import '../../../../domain/use_cases/delete_item_in_cart_use_case.dart';
import '../../../../domain/use_cases/get_cart_use_case.dart';
import '../../../../domain/use_cases/update_count_item_use_case.dart';

class CartViewModel extends Cubit<CartStates> {
  GetCartUseCase getCartUseCase;
  DeleteItemInCartUseCase deleteItemInCartUseCase;
  UpdateItemInCartUseCase updateItemInCartUseCase;
  CheckOutItemsUseCase checkOutItemsUseCase;

  CartViewModel(
      {required this.getCartUseCase,
      required this.deleteItemInCartUseCase,
      required this.updateItemInCartUseCase,
      required this.checkOutItemsUseCase})
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
    emit(CartLoadingState());
    var either = await deleteItemInCartUseCase.invoke(productId);
    either.fold((l) {
      emit(DeleteItemInCartErrorState(errors: l));
    }, (response) {
      cartItemsList = response.data!.products ?? [];
      emit(CartSuccessState(cartResponseEntity: response));
    });
  }

  void deleteAllItemsInCart() async {
    emit(DeleteAllItemsInCartLoadingState());
    var either = await deleteItemInCartUseCase.invokeALlItems();
    either.fold((l) {
      emit(DeleteAllItemsInCartErrorState(errors: l));
    }, (response) {
      if (response.data != null && response.data!.products != null) {
        cartItemsList = response.data!.products!;
      } else {
        cartItemsList = [];
      }
      emit(DeleteAllItemsInCartSuccessState());
    });
  }

  void updateItemCount(String productId, int count) async {
    emit(CartLoadingState());
    var either = await updateItemInCartUseCase.invoke(productId, count);
    either.fold((l) {
      emit(UpdateItemCountErrorState(errors: l));
    }, (response) {
      cartItemsList = response.data!.products ?? [];
      emit(CartSuccessState(cartResponseEntity: response));
    });
  }

  Future<String?> checkOutItems(int amount) async {
    emit(CheckOutLoadingState());
    var token = await checkOutItemsUseCase.invoke(amount);
    emit(CheckOutSuccessState(token: token));
    return token;
  }
}
