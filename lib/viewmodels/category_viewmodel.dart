import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/category_model.dart';

class CategoryViewModel {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  List<CategoryModel> listCategory = [];

  Future<List<CategoryModel>> getAllCategories() async {
    listCategory = [];
    var data = await firebaseFirestore.collection('categories').get();
    for (var d in data.docs) {
      listCategory.add(CategoryModel.fromMap(d.data()));
    }

    return listCategory;
  }
}
