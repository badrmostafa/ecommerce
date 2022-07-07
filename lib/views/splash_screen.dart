import 'dart:async';
import 'package:ecommerce_app/models/cart_model.dart';
import 'package:ecommerce_app/models/favorite_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/viewmodels/cart_viewmodels.dart';
import 'package:ecommerce_app/viewmodels/favorite_viewmodel.dart';
import 'package:ecommerce_app/views/home_screen.dart';
//import 'package:ecommerce_app/views/onboard_screen.dart';
//import 'package:ecommerce_app/views/shared_prefernces.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../viewmodels/category_viewmodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  CategoryViewModel categoryViewModel = CategoryViewModel();
  CartViewModel cartViewModel = CartViewModel();
  List<CategoryModel> categoryList = [];
  List<ProductModel> productList = [];
  FavoriteViewModel favoriteViewModel = FavoriteViewModel();
  List<FavoriteModel> favoriteList = [];
  List<CartProduct> allCartsList = [];

  @override
  void initState() {
    super.initState();
    getAllCategories();
    getAllFavorites();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomeScreen(
            allCategories: categoryList,
            allProducts: productList,
            allFavorites: favoriteList);
      }));
    });
  }

  void getAllCategories() async {
    categoryList = await categoryViewModel.getAllCategories();
    productList = [];
    for (var category in categoryList) {
      for (var product in category.products!) {
        productList.add(product);
      }
    }

    debugPrint('splash...${productList.length}');
  }

  Future<void> getAllFavorites() async {
    favoriteList = await favoriteViewModel.getFavorites();
    debugPrint('fav list ${favoriteList.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Image.asset('images/splash_cart.png'),
        ));
  }
}
