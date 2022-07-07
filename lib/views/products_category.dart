import 'package:ecommerce_app/models/string_color.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';

class ProductsCategory extends StatefulWidget {
  final CategoryModel categoryModel;
  const ProductsCategory({required this.categoryModel, Key? key})
      : super(key: key);

  @override
  State<ProductsCategory> createState() => _ProductsCategoryState();
}

class _ProductsCategoryState extends State<ProductsCategory> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white12,
          body: allProducts(widget.categoryModel)),
    );
  }

  Widget allProducts(CategoryModel category) {
    var products = category.products;
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
          itemCount: category.products!.length,
          itemBuilder: (context, i) {
            return Card(
              color: Colors.orange.shade200,
              child: Column(children: [
                Container(
                    decoration: const BoxDecoration(),
                    height: 70,
                    width: 130,
                    child: Image.network(products![i].image!)),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  products[i].name!,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(15),
                      color: HexColor(products[i].color!)),
                  height: 20,
                  width: 40,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('\$${products[i].price!}',
                    style: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 7,
                )
              ]),
            );
          }),
    );
  }
}
