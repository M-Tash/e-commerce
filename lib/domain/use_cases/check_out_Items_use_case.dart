import '../repository/repository/cart_repository.dart';

class CheckOutItemsUseCase {
  CartRepository cartRepository;

  CheckOutItemsUseCase({required this.cartRepository});

  Future<String?> invoke(int amount) {
    return cartRepository.checkOutItemsInCart(amount);
  }
}
