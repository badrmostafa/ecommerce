import 'package:ecommerce_app/models/constants.dart';

class CartProduct {
  int? id;
  String? name, image, price;
  int? quantity;

  CartProduct({this.id, this.name, this.image, this.price, this.quantity});

  factory CartProduct.fromMap(Map<String, dynamic> map) {
    return CartProduct(
        id: map[columnCartId],
        name: map[columnName],
        image: map[columnImage],
        price: map[columnPrice],
        quantity: map[columnQuantity]);
  }

  Map<String, dynamic> toMap() {
    return {
      columnName: name,
      columnImage: image,
      columnPrice: price,
      columnQuantity: quantity,
    };
  }
}
