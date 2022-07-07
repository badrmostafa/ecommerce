import 'package:ecommerce_app/models/favorite_model.dart';
import 'package:ecommerce_app/viewmodels/database/favorite_database.dart';

class FavoriteViewModel {
  Favorite favorite = Favorite.instance;

  List<FavoriteModel> listFav = [];
  Future<void> addToFavorite(FavoriteModel model) async {
    await favorite.insertFavorite(model);
  }

  Future<List<FavoriteModel>> getFavorites() async {
    listFav = [];
    listFav = await favorite.getAllFavorites();
    return listFav;
  }

  Future<void> deleteFavorite(int id) async {
    await favorite.removeFavorite(id);
  }
}
