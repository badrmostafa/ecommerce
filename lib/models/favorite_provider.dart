import 'package:ecommerce_app/models/favorite_model.dart';
import 'package:ecommerce_app/viewmodels/favorite_viewmodel.dart';
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  FavoriteViewModel favoriteViewModel = FavoriteViewModel();
  List<FavoriteModel> favList = [];
  List<String> images = [];

  Future<List<FavoriteModel>> getAllFavorites() async {
    favList = [];
    images = [];
    favList = await favoriteViewModel.getFavorites();

    for (FavoriteModel fav in favList) {
      images.add(fav.image!);
    }

    print('fav length in provider: ${favList.length}');
    print('img length in provider: ${images.length}');

    notifyListeners();
    return favList;
  }

  Future<void> removeFavorite(int id) async {
    await favoriteViewModel.deleteFavorite(id);
    notifyListeners();
  }
}
