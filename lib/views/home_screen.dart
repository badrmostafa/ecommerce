import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ecommerce_app/models/carts_provider.dart';
import 'package:ecommerce_app/models/favorite_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/viewmodels/category_viewmodel.dart';
import 'package:ecommerce_app/views/allproducts_screen.dart';
import 'package:ecommerce_app/views/productdetails_screen.dart';
import 'package:ecommerce_app/views/products_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../models/cart_model.dart';
import '../models/category_model.dart';
import '../models/favorite_provider.dart';
import '../models/string_color.dart';
import '../viewmodels/cart_viewmodels.dart';
import '../viewmodels/favorite_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  static const String homeRoute = 'home';

  final List<ProductModel> allProducts;
  final List<CategoryModel> allCategories;
  final List<FavoriteModel> allFavorites;

  const HomeScreen(
      {required this.allFavorites,
      required this.allCategories,
      required this.allProducts,
      Key? key})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FavoriteModel> favoriteList = [];
  List<String> images = [];
  List<CategoryModel> allCategories = [];
  late Future<List<CategoryModel>> future;
  CategoryViewModel categoryViewModel = CategoryViewModel();
  FavoriteViewModel favoriteViewModel = FavoriteViewModel();
  FavoriteModel favoriteModel = FavoriteModel();
  bool redColor = false;
  CartViewModel cartViewModel = CartViewModel();
  List<CartProduct> listCart = [];
  late Future<List<CartProduct>> futureCart;
  List<FavoriteModel> favoriteListDemo = [];

  List<CartProduct> allCartsList = [];
  late Future<List<FavoriteModel>> futureFav;

  @override
  initState() {
    super.initState();
    futureCart =
        Provider.of<CartProvider>(context, listen: false).getAllCarts();
    futureFav =
        Provider.of<FavoriteProvider>(context, listen: false).getAllFavorites();

    future = allCategoriesData();
  }

  Future<void> addFavorite(FavoriteModel model) async {
    await favoriteViewModel.addToFavorite(model);
  }

  void allFavorites() async {
    images = [];
    favoriteListDemo = [];
    favoriteListDemo = await favoriteViewModel.getFavorites();
    favoriteList = [];
    for (int i = 0; i < favoriteListDemo.length; i++) {
      favoriteList.add(favoriteListDemo[i]);
      images.add(favoriteListDemo[i].image!);
    }
    debugPrint('favorite list length: ${favoriteList.length}');
    debugPrint('img list : ${images.length}');
  }

  Future<List<CategoryModel>> allCategoriesData() async {
    var data = await categoryViewModel.getAllCategories();

    for (int i = 0; i < data.length; i++) {
      allCategories.add(data[i]);
    }

    return allCategories;
  }

  Future<void> deleteProduct(FavoriteModel model) async {
    await favoriteViewModel.deleteFavorite(model.id!);
  }

  void getAllCarts1() async {
    allCartsList = [];
    allCartsList = await cartViewModel.allCarts();
    debugPrint('get all carts one: ${allCartsList.length}');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
            bottomNavigationBar: Material(
              color: Colors.orange.shade200,
              child: TabBar(
                  labelColor: Colors.black,
                  indicatorColor: Colors.black,
                  unselectedLabelColor: Colors.black45,
                  padding: const EdgeInsets.only(
                    top: 11,
                  ),
                  tabs: const [
                    Icon(Icons.explore),
                    Icon(Icons.shopping_cart),
                    Icon(Icons.favorite)
                  ]),
            ),
            backgroundColor: Colors.white12,
            body: TabBarView(
              children: [explore(), cartScreen(), allFavoritesList()],
            )),
      ),
    );
  }

  Widget explore() {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.orange.shade200,
                  borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Search',
                    contentPadding: EdgeInsets.only(top: -3),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.black)),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            AnimatedTextKit(pause: Duration(seconds: 3), animatedTexts: [
              TypewriterAnimatedText('Categories',
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ]),
            const SizedBox(
              height: 15,
            ),
            categories(),
            const SizedBox(
              height: 23,
            ),
            bestSelling(),
          ]),
        ),
      ],
    );
  }

  Widget cartScreen() {
    List<CartProduct> carts = Provider.of<CartProvider>(context).cartModelList;
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<CartProduct>>(
              future: futureCart,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    decoration: const BoxDecoration(),
                    child: ListView.separated(
                      itemCount: carts.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(5),
                          child: Row(children: [
                            Container(
                                height: 120,
                                width: 115,
                                color: Colors.grey,
                                child: Image.network(carts[index].image!,
                                    fit: BoxFit.fill)),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  carts[index].name!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '\$${carts[index].price!}',
                                  style: const TextStyle(color: Colors.green),
                                ),
                                const SizedBox(
                                  height: 13,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 40),
                                  child: Container(
                                    width: 110,
                                    height: 35,
                                    color: Colors.cyan.shade100,
                                    child: Row(
                                      children: [
                                        Container(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: GestureDetector(
                                                onTap: () async {
                                                  int qty =
                                                      Provider.of<CartProvider>(
                                                              context,
                                                              listen: false)
                                                          .incrementQuantity(
                                                              carts[index]
                                                                  .quantity!);
                                                  print('qty: $qty');
                                                  await Provider.of<
                                                              CartProvider>(
                                                          context,
                                                          listen: false)
                                                      .updateCartProduct(
                                                          CartProduct(
                                                              id: carts[index]
                                                                  .id,
                                                              image:
                                                                  carts[index]
                                                                      .image,
                                                              name: carts[index]
                                                                  .name,
                                                              price:
                                                                  carts[index]
                                                                      .price,
                                                              quantity: qty))
                                                      .then((value) {
                                                    Provider.of<CartProvider>(
                                                            context,
                                                            listen: false)
                                                        .getAllCarts();
                                                  });
                                                },
                                                child: const Icon(Icons.add))),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text('${carts[index].quantity}',
                                            textAlign: TextAlign.center),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 15),
                                            child: GestureDetector(
                                                onTap: () async {
                                                  int qty =
                                                      Provider.of<CartProvider>(
                                                              context,
                                                              listen: false)
                                                          .decrementQuantity(
                                                              carts[index]
                                                                  .quantity!);

                                                  await Provider.of<
                                                              CartProvider>(
                                                          context,
                                                          listen: false)
                                                      .updateCartProduct(
                                                          CartProduct(
                                                              id: carts[index]
                                                                  .id,
                                                              image:
                                                                  carts[index]
                                                                      .image,
                                                              name: carts[index]
                                                                  .name,
                                                              price:
                                                                  carts[index]
                                                                      .price,
                                                              quantity: qty))
                                                      .then((value) {
                                                    Provider.of<CartProvider>(
                                                            context,
                                                            listen: false)
                                                        .getAllCarts();
                                                  });
                                                },
                                                child:
                                                    const Icon(Icons.minimize)))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ]),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 5,
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text('Total', style: TextStyle(color: Colors.white)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '\$${Provider.of<CartProvider>(context).totalPrice}',
                    style: const TextStyle(color: Colors.red),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget categories() {
    return Container(
      decoration: const BoxDecoration(),
      height: 85,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.allCategories.length,
        itemBuilder: (contxet, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProductsCategory(
                  categoryModel: widget.allCategories[index],
                );
              }));
            },
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.orange.shade200,
                      borderRadius: BorderRadius.circular(60)),
                  child: Image.network(widget.allCategories[index].image!),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(widget.allCategories[index].name!,
                    style: const TextStyle(fontSize: 12, color: Colors.white))
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 10);
        },
      ),
    );
  }

  Widget bestSelling() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Best Selling',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AllProductsScreen(products: widget.allProducts);
                }));
              },
              child: const Text(
                'See all',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          decoration: const BoxDecoration(),
          height: 320,
          child: AnimationLimiter(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(seconds: 2),
                  child: SlideAnimation(
                    horizontalOffset: 200,
                    child: FadeInAnimation(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ProductsDetailsScreen(
                                  product: widget.allProducts[index]);
                            },
                          ));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: 210,
                                width: 180,
                                decoration: BoxDecoration(
                                    color: Colors.orange.shade200),
                                child: Image.network(
                                  widget.allProducts[index].image!,
                                  fit: BoxFit.cover,
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.allProducts[index].name!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 17,
                              width: 25,
                              decoration: BoxDecoration(
                                  color: HexColor(
                                      widget.allProducts[index].color!),
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  '\$${widget.allProducts[index].price!}',
                                  style: const TextStyle(color: Colors.green),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                GestureDetector(
                                    onTap: () async {
                                      await addFavorite(FavoriteModel(
                                              image: widget
                                                  .allProducts[index].image,
                                              name: widget
                                                  .allProducts[index].name,
                                              color: widget
                                                  .allProducts[index].color,
                                              price: widget
                                                  .allProducts[index].price,
                                              isFavorite: 1))
                                          .then((value) {
                                        Provider.of<FavoriteProvider>(context,
                                                listen: false)
                                            .getAllFavorites();
                                      });
                                    },
                                    child: Icon(Icons.favorite,
                                        color: Provider.of<FavoriteProvider>(
                                                    context,
                                                    listen: false)
                                                .images
                                                .contains(widget
                                                    .allProducts[index].image)
                                            ? Colors.red
                                            : Colors.white)),
                                const SizedBox(width: 10),
                                SizedBox(
                                  height: 20,
                                  width: 58,
                                  child: ElasticIn(
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    Colors.orange.shade200)),
                                        onPressed: () async {
                                          await cartViewModel
                                              .insertCart(CartProduct(
                                                  image: widget
                                                      .allProducts[index].image,
                                                  name: widget
                                                      .allProducts[index].name,
                                                  price: widget
                                                      .allProducts[index].price,
                                                  quantity: 1))
                                              .then((value) async {
                                            await Provider.of<CartProvider>(
                                                    context,
                                                    listen: false)
                                                .getAllCarts();
                                          });
                                        },
                                        child: Text('Add',
                                            style: TextStyle(
                                                color: Colors.black))),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 10);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget allFavoritesList() {
    List<FavoriteModel> listFav =
        Provider.of<FavoriteProvider>(context).favList;
    return FutureBuilder<List<FavoriteModel>>(
        future: futureFav,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: listFav.length,
                itemBuilder: (context, i) {
                  return Card(
                    color: Colors.orange.shade200,
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(),
                          width: 100,
                          height: 70,
                          child: Image.network(listFav[i].image!),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(listFav[i].name!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              width: 2,
                            ),
                            GestureDetector(
                                onTap: () async {
                                  await Provider.of<FavoriteProvider>(context,
                                          listen: false)
                                      .removeFavorite(listFav[i].id!)
                                      .then((value) {
                                    Provider.of<FavoriteProvider>(context,
                                            listen: false)
                                        .getAllFavorites();
                                  });
                                },
                                child: const Icon(Icons.favorite,
                                    color: Colors.red))
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 17,
                          width: 25,
                          decoration: BoxDecoration(
                              color: HexColor(listFav[i].color!),
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '\$${listFav[i].price}',
                          style: const TextStyle(color: Colors.green),
                        )
                      ],
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
