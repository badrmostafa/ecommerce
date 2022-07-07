import 'dart:async';
import 'package:ecommerce_app/models/constants.dart';
import 'package:ecommerce_app/models/favorite_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Favorite {
  Favorite._singleton();

  static final Favorite instance = Favorite._singleton();

  List<FavoriteModel> allFavorites = [];

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await createDatabase();
      return _database!;
    }
  }

  Future<Database> createDatabase() async {
    String path = join(await getDatabasesPath(), 'FavoriteDatabase.db');
    return await openDatabase(path,
        version: 1, onCreate: createFavoriteDatabase);
  }

  Future<void> createFavoriteDatabase(Database db, int version) async {
    await db.execute('''
                     CREATE TABLE $tableFavoriteName(
                        $idColumnFavorite $idColumnFavoriteQuery,
                        $columnImage $columnImageQuery,
                        $columnName $columnNameQuery,
                        $columnPrice $columnPriceQuery,
                        $columnColor $columnColorQuery,
                        $favoriteColumn $favoriteColumnQuery
                       )
               ''');
  }

  Future<void> insertFavorite(FavoriteModel favorite) async {
    bool isExist = false;
    int i = 0;
    while (i < allFavorites.length) {
      if (allFavorites[i].image == favorite.image) {
        isExist = true;
      }
      i++;
    }
    if (!isExist) {
      final db = await instance.database;
      await db.insert(tableFavoriteName, favorite.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      Fluttertoast.showToast(
          msg: 'Product ${favorite.name} is added in favorite');
    } else {
      Fluttertoast.showToast(
          msg: 'Product ${favorite.name} already in favorites');
    }
  }

  Future<List<FavoriteModel>> getAllFavorites() async {
    final db = await instance.database;
    List<Map<String, Object?>> list = await db.query(tableFavoriteName);
    if (list.isEmpty) {
      return <FavoriteModel>[];
    } else {
      allFavorites = [];
      for (int i = 0; i < list.length; i++) {
        allFavorites.add(FavoriteModel.fromMap(list[i]));
      }
      debugPrint('all favorites: ${allFavorites.length}');
      return allFavorites;
    }
  }

  Future<void> removeFavorite(int id) async {
    final db = await instance.database;
    await db.delete(tableFavoriteName, where: 'id = ?', whereArgs: [id]);
    Fluttertoast.showToast(msg: 'This Product is removed from favorites');
  }
}
