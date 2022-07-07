import 'package:ecommerce_app/models/constants.dart';
import 'package:ecommerce_app/models/product_model.dart';

class CategoryModel {
  String? name;
  String? image;
  List<ProductModel>? products;

  CategoryModel({this.name, this.image, this.products});

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    final products = map[productsColumn] as List<dynamic>?;
    List<ProductModel> listProductModel = [];

    for (int i = 0; i < products!.length; i++) {
      listProductModel.add(ProductModel.fromMap(products[i]));
    }

    return CategoryModel(
        name: map[nameColumn],
        image: map[imageColumn],
        products: listProductModel);
  }

  Map<String, dynamic> toMap() => {
        nameColumn: name,
        imageColumn: image,
        productsColumn: products!.map((p) => p.toMap()).toList()
      };
}
