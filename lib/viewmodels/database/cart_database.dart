import 'dart:async';

import 'package:ecommerce_app/models/cart_model.dart';
import 'package:ecommerce_app/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartProductDatabase {
  static CartProductDatabase instance = CartProductDatabase._singleton();

  CartProductDatabase._singleton();

  Database? _database;

  List<CartProduct> cartList = [];

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initdb();
    return _database!;
  }

  Future<Database> initdb() async {
    String path = join(await getDatabasesPath(), 'CartProduct.db');
    return await openDatabase(path, version: 1, onCreate: creatdb);
  }

  FutureOr<void> creatdb(Database db, int version) {
    db.execute('''
            CREATE TABLE $tableCartName (
              $columnCartId $columnCartIdQuery,
              $columnName $columnNameQuery,
              $columnImage $columnImageQuery,
              $columnPrice $columnPriceQuery,
              $columnQuantity $columnQuantityQuery
            )
      ''');
  }

  Future<void> addCart(CartProduct cartProduct) async {
    bool isExist = false;
    debugPrint('cart list length in db... : ${cartList.length}');
    for (int i = 0; i < cartList.length; i++) {
      if (cartProduct.image == cartList[i].image) {
        isExist = true;
        break;
      }
    }
    if (isExist == false) {
      final db = await instance.database;
      await db.insert(tableCartName, cartProduct.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      Fluttertoast.showToast(
          msg: 'Product ${cartProduct.name} is added to cart');
    } else {
      Fluttertoast.showToast(
          msg: 'Product ${cartProduct.name} already exist in cart');
    }
  }

  Future<List<CartProduct>> getCarts() async {
    final db = await instance.database;
    List<Map<String, Object?>> listMap = await db.query(tableCartName);
    if (listMap.isEmpty) {
      return <CartProduct>[];
    } else {
      cartList = [];
      for (Map<String, Object?> product in listMap) {
        cartList.add(CartProduct.fromMap(product));
      }
      debugPrint('cart List length in db: ${cartList.length}');
      return cartList;
    }
  }

  Future<void> updatecart(CartProduct cart) async {
    final db = await instance.database;

    await db.update(tableCartName, cart.toMap(),
        where: '$columnCartId = ?', whereArgs: [cart.id]);
    print('update done....');
  }
}
