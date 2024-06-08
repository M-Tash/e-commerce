import '../../../../domain/entities/AddCartResponseEntity.dart';
import '../../../../domain/entities/failures.dart';

abstract class HomeScreenState {}

class HomeInitState extends HomeScreenState {}

class ChangeNavBarState extends HomeScreenState {}

class AddToCartInitState extends HomeScreenState {}

class AddToCartLoadingState extends HomeScreenState {}

class AddToCartErrorState extends HomeScreenState {
  Failures? errors;

  AddToCartErrorState({required this.errors});
}

final class AddToCartSuccessState extends HomeScreenState {
  AddCartResponseEntity addCartResponseEntity;

  AddToCartSuccessState({required this.addCartResponseEntity});
}
