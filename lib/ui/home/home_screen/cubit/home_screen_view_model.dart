import 'package:e_commerce/ui/home/home_screen/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/use_cases/add_cart_use_case.dart';
import '../../tabs/favorite_tab/favorite_tab.dart';
import '../../tabs/home_tab/home_tab.dart';
import '../../tabs/product_list_tab/product_list_tab.dart';
import '../../tabs/profile_tab/profile_tab.dart';

class HomeScreenViewModel extends Cubit<HomeScreenState> {
  AddToCartUseCase addToCartUseCase;

  HomeScreenViewModel({required this.addToCartUseCase})
      : super(HomeInitState());
  int selectedIndex = 0;
  int numOfItemsInCart = 0;
  List<Widget> tabs = [
    HomeTab(),
    ProductListTab(),
    FavoriteTab(),
    ProfileTab()
  ];

  static HomeScreenViewModel getBloc(context) => BlocProvider.of(context);

  void changeSelectedIndex(int newSelectedIndex) {
    emit(HomeInitState());
    selectedIndex = newSelectedIndex;
    emit(ChangeNavBarState());
  }

  void addToCart(String productId) async {
    emit(AddToCartLoadingState());
    var either = await addToCartUseCase.invoke(productId: productId);
    either.fold((l) => emit(AddToCartErrorState(errors: l)), (response) {
      numOfItemsInCart = response.numOfCartItems!.toInt();
      emit(
        AddToCartSuccessState(addCartResponseEntity: response),
      );
    });
  }
}
