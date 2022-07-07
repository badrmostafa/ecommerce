import 'package:flutter/material.dart';

import 'cart_model.dart';

class ChangePrice extends ChangeNotifier {
  int totalPrice = 0;

  void changeTotalPrice(List<CartProduct> listCart) {
    totalPrice = 0;
    for (int i = 0; i < listCart.length; i++) {
      int price = int.parse(listCart[i].price.toString());
      totalPrice = totalPrice + price;
    }
    notifyListeners();
  }
}
