import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/favorites_model.dart';

class FavoritesController extends GetxController {
  static FavoritesController get instance => Get.find();

  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('Favorites');

  RxList<FavoriteModel> favorites = RxList<FavoriteModel>();

  @override
  void onInit() {
    super.onInit();
    bindFavorites();
  }

  Future<void> addFavorite(FavoriteModel favorite) async {
    try {
      await collection.add(favorite.toJson());
    } catch (e) {
      print("Error adding favorite: $e");
    }
  }

  Future<void> updateFavorite(String id, FavoriteModel favorite) async {
    try {
      await collection.doc(id).update(favorite.toJson());
    } catch (e) {
      print("Error updating favorite: $e");
    }
  }

  Future<void> deleteFavorite(String id) async {
    try {
      await collection.doc(id).delete();
    } catch (e) {
      print("Error deleting favorite: $e");
    }
  }

  void bindFavorites() {
    collection.snapshots().listen((snapshot) async {
      List<FavoriteModel> favs = await Future.wait(snapshot.docs.map((doc) async {
        return await FavoriteModel.fromSnapshot(doc);
      }).toList());
      favorites.assignAll(favs);
    });
  }
}
