import 'package:ecommerce_app/models/cart_model.dart';
import 'package:ecommerce_app/models/carts_provider.dart';
import 'package:ecommerce_app/models/favorite_model.dart';
import 'package:ecommerce_app/models/string_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorite_provider.dart';
import '../models/product_model.dart';
import '../viewmodels/cart_viewmodels.dart';

class ProductsDetailsScreen extends StatefulWidget {
  static const String productDetailsRoute = 'product details';
  final ProductModel product;
  const ProductsDetailsScreen({required this.product, Key? key})
      : super(key: key);

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  CartViewModel cartViewModel = CartViewModel();
  List<FavoriteModel> list = [];
  @override
  void initState() {
    super.initState();
    allFav();
  }

  void getAllCarts() async {
    await cartViewModel.allCarts();
  }

  void allFav() async {
    list = [];
    list = await Provider.of<FavoriteProvider>(context, listen: false)
        .getAllFavorites();
    print('get all fav in details.');
  }

  int getId(String img) {
    int id = 0;
    for (FavoriteModel fav in list) {
      if (fav.image == img) {
        id = fav.id!;
        break;
      }
    }
    return id;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:
            Scaffold(backgroundColor: Colors.white12, body: productDetails()));
  }

  Widget productDetails() {
    return Column(children: [
      Container(
        height: 250,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.orange.shade200),
        child: Image.network(widget.product.image!, fit: BoxFit.fill),
      ),
      Expanded(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    widget.product.name!,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ]),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .4,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.orange.shade200,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Size'),
                          Text(widget.product.size!)
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                          color: Colors.orange.shade200,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Color',
                              style: TextStyle(color: Colors.black)),
                          Container(
                            height: 15,
                            width: 25,
                            decoration: BoxDecoration(
                                color: HexColor(widget.product.color!),
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(40)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 13),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Details',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  widget.product.description!,
                  style: const TextStyle(height: 1.8, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text(
                  'Price',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '\$${widget.product.price}',
                  style: const TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(width: 80),
            iconFavorite(widget.product.image!, getId(widget.product.image!)) ??
                Text(''),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.orange.shade200)),
                onPressed: () async {
                  await cartViewModel
                      .insertCart(
                    CartProduct(
                        name: widget.product.name,
                        image: widget.product.image,
                        price: widget.product.price,
                        quantity: 1),
                  )
                      .then((value) async {
                    await Provider.of<CartProvider>(context, listen: false)
                        .getAllCarts();
                  });
                },
                child: const Text('Add To Cart',
                    style: TextStyle(color: Colors.black)))
          ],
        ),
      )
    ]);
  }

  Widget? iconFavorite(String img, int id) {
    List<String> list = Provider.of<FavoriteProvider>(context).images;

    if (list.contains(img)) {
      return GestureDetector(
          onTap: () async {
            await Provider.of<FavoriteProvider>(context, listen: false)
                .removeFavorite(id)
                .then((value) {
              Provider.of<FavoriteProvider>(context, listen: false)
                  .getAllFavorites();
            });
          },
          child: Icon(Icons.favorite, color: Colors.red));
    } else {
      return null;
    }
  }
}
