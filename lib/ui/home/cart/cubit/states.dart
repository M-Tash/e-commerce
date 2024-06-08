import 'package:e_commerce/domain/entities/GetCartResponseEntity.dart';

import '../../../../domain/entities/failures.dart';

abstract class CartStates {}

class CartInitState extends CartStates {}

class CartLoadingState extends CartStates {}

class CartErrorState extends CartStates {
  Failures? errors;

  CartErrorState({required this.errors});
}

class CartSuccessState extends CartStates {
  CartResponseEntity cartResponseEntity;

  CartSuccessState({required this.cartResponseEntity});
}

class DeleteItemInCartLoadingState extends CartStates {}

class DeleteItemInCartErrorState extends CartStates {
  Failures? errors;

  DeleteItemInCartErrorState({required this.errors});
}

class DeleteItemInCartSuccessState extends CartStates {
  CartResponseEntity cartResponseEntity;

  DeleteItemInCartSuccessState({required this.cartResponseEntity});
}

class UpdateItemCountLoadingState extends CartStates {}

class UpdateItemCountErrorState extends CartStates {
  Failures? errors;

  UpdateItemCountErrorState({required this.errors});
}

class UpdateItemCountSuccessState extends CartStates {
  CartResponseEntity cartResponseEntity;

  UpdateItemCountSuccessState({required this.cartResponseEntity});
}
