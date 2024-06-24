import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/ingredient_model.dart';

class IngredientController extends GetxController {
  static IngredientController get instance => Get.find();

  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('Ingredients');

  RxList<IngredientModel> ingredients = RxList<IngredientModel>();

  @override
  void onInit() {
    super.onInit();
    ingredients.bindStream(getIngredients());
  }

  Future<void> addIngredient(IngredientModel ingredient) async {
    try {
      await collection.add(ingredient.toJson());
    } catch (e) {
      print("Error adding ingredient: $e");
    }
  }

  Future<void> updateIngredient(String id, IngredientModel ingredient) async {
    try {
      await collection.doc(id).update(ingredient.toJson());
    } catch (e) {
      print("Error updating ingredient: $e");
    }
  }

  Future<void> deleteIngredient(String id) async {
    try {
      await collection.doc(id).delete();
    } catch (e) {
      print("Error deleting ingredient: $e");
    }
  }

  Stream<List<IngredientModel>> getIngredients() {
    return collection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => IngredientModel.fromSnapshot(doc))
          .toList();
    });
  }
}
