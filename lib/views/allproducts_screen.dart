import 'package:ecommerce_app/models/cart_model.dart';
import 'package:ecommerce_app/models/favorite_model.dart';
import 'package:ecommerce_app/models/favorite_provider.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/models/string_color.dart';
import 'package:ecommerce_app/viewmodels/cart_viewmodels.dart';
import 'package:ecommerce_app/viewmodels/favorite_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/carts_provider.dart';

class AllProductsScreen extends StatefulWidget {
  final List<ProductModel> products;
  const AllProductsScreen({required this.products, Key? key}) : super(key: key);

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  CartViewModel cartViewModel = CartViewModel();
  FavoriteViewModel favoriteViewModel = FavoriteViewModel();

  Future<void> addCart(CartProduct cart) async {
    await cartViewModel.insertCart(cart);
  }

  Future<void> addFavorite(FavoriteModel fav) async {
    await favoriteViewModel.addToFavorite(fav);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(backgroundColor: Colors.white12, body: listProducts()));
  }

  Widget listProducts() {
    return Container(
      decoration: const BoxDecoration(),
      child: ListView.builder(
          itemCount: widget.products.length,
          itemBuilder: (context, i) {
            return Card(
              color: Colors.orange.shade200,
              child: Column(children: [
                Container(
                    height: 100,
                    child: Image.network(widget.products[i].image!,
                        fit: BoxFit.fill)),
                const SizedBox(
                  height: 5,
                ),
                Text(widget.products[i].name!,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 20,
                  width: 40,
                  decoration: BoxDecoration(
                      color: HexColor(widget.products[i].color!),
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(15)),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 20,
                ),
                Text('\$${widget.products[i].price}',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          await addFavorite(FavoriteModel(
                                  name: widget.products[i].name,
                                  image: widget.products[i].image,
                                  color: widget.products[i].color,
                                  price: widget.products[i].price,
                                  isFavorite: 1))
                              .then((value) {
                            Provider.of<FavoriteProvider>(context,
                                    listen: false)
                                .getAllFavorites();
                          });
                        },
                        child: Icon(Icons.favorite,
                            color: Provider.of<FavoriteProvider>(context)
                                    .images
                                    .contains(widget.products[i].image)
                                ? Colors.red
                                : Colors.white)),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 20,
                      width: 58,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.orange.shade400),
                          ),
                          onPressed: () {},
                          child: GestureDetector(
                            onTap: () async {
                              await addCart(CartProduct(
                                      image: widget.products[i].image,
                                      name: widget.products[i].name,
                                      price: widget.products[i].price,
                                      quantity: 1))
                                  .then((value) {
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .getAllCarts();
                              });
                            },
                            child: SizedBox(
                              height: 15,
                              width: 30,
                              child: const Text('Add',
                                  style: TextStyle(color: Colors.black)),
                            ),
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                )
              ]),
            );
          }),
    );
  }
}
