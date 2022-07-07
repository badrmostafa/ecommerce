import 'package:ecommerce_app/models/constants.dart';

class ProductModel {
  String? name;
  String? image;
  String? color;
  String? description;
  String? price;
  String? size;

  ProductModel(
      {this.name,
      this.image,
      this.color,
      this.description,
      this.price,
      this.size});

  factory ProductModel.fromMap(dynamic map) {
    return ProductModel(
        name: map[productName],
        image: map[productImage],
        color: map[productColor],
        description: map[productDescription],
        price: map[productPrice],
        size: map[productSize]);
  }

  Map<String, dynamic> toMap() => {
        productName: name,
        productColor: color,
        productImage: image,
        productDescription: description,
        productPrice: price,
        productSize: size,
      };
}
