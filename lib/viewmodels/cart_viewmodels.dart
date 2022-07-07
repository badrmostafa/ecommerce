import 'package:ecommerce_app/models/cart_model.dart';
import 'package:ecommerce_app/viewmodels/database/cart_database.dart';

class CartViewModel {
  CartProductDatabase cartProductDatabase = CartProductDatabase.instance;
  List<CartProduct> listCartProduct = [];

  Future<void> insertCart(CartProduct cartProduct) async {
    await cartProductDatabase.addCart(cartProduct);
  }

  Future<List<CartProduct>> allCarts() async {
    listCartProduct = [];
    listCartProduct = await cartProductDatabase.getCarts();
    return listCartProduct;
  }

  Future<void> editCart(CartProduct cart) async {
    await cartProductDatabase.updatecart(cart);
  }
}
