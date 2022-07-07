import 'package:ecommerce_app/models/constants.dart';

class FavoriteModel {
  int? id;
  String? name;
  String? image;
  String? price;
  String? color;
  int? isFavorite;

  FavoriteModel(
      {this.id,
      this.name,
      this.image,
      this.color,
      this.isFavorite,
      this.price});

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
        id: map[idColumnFavorite],
        name: map[columnName],
        image: map[columnImage],
        price: map[columnPrice],
        color: map[columnColor],
        isFavorite: map[favoriteColumn]);
  }

  Map<String, dynamic> toMap() {
    return {
      columnName: name,
      columnImage: image,
      columnPrice: price,
      columnColor: color,
      favoriteColumn: isFavorite
    };
  }
}
