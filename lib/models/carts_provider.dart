import 'package:ecommerce_app/models/cart_model.dart';
import 'package:ecommerce_app/viewmodels/cart_viewmodels.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  CartViewModel cartViewModel = CartViewModel();

  List<CartProduct> cartModelList = [];
  int totalPrice = 0;

  Future<List<CartProduct>> getAllCarts() async {
    cartModelList = [];
    totalPrice = 0;
    cartModelList = await cartViewModel.allCarts();

    int i = 0;
    while (i < cartModelList.length) {
      int price = int.parse(cartModelList[i].price.toString());
      totalPrice = totalPrice + (price * cartModelList[i].quantity!);
      i++;
    }

    print('cart length in provider: ${cartModelList.length}');
    print('total price in provider: $totalPrice');

    notifyListeners();
    return cartModelList;
  }

  Future<void> updateCartProduct(CartProduct cart) async {
    await cartViewModel.editCart(cart);

    notifyListeners();
  }

  int incrementQuantity(int quantity) {
    quantity++;
    notifyListeners();
    print('quantity: ${quantity}');
    return quantity;
  }

  int decrementQuantity(int quantity) {
    quantity--;
    notifyListeners();
    return quantity;
  }
}
