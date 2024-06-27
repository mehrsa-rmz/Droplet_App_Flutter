import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/favorites_model.dart';

class FavoritesController extends GetxController {
  static FavoritesController get instance => Get.put(FavoritesController());

  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('Favorites');

  RxList<FavoriteModel> favorites = RxList<FavoriteModel>();
  RxInt favoriteCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    bindFavorites();
  }

  // Function to fetch the current user's favorite items
  Future<List<FavoriteModel>> fetchCurrentUserFavorites() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final querySnapshot = await collection.where('customerId', isEqualTo: user.uid).get();
        List<FavoriteModel> fetchedFavorites  = await Future.wait(
          querySnapshot.docs.map((doc) async {
            return await FavoriteModel.fromSnapshot(doc);
          }).toList()
        );
        favorites.assignAll(fetchedFavorites);
        favoriteCount.value = fetchedFavorites.length;
        return fetchedFavorites;
      } else {
        print("No user is currently signed in.");
        return [];
      }
    } catch (e) {
      print("Error fetching current user favorites: $e");
      return [];
    }
  }

  Future<void> addFavorite(FavoriteModel favorite) async {
    try {
      print("Adding favorite: ${favorite.toJson()}"); // Debug statement
      await collection.add(favorite.toJson());
      print("Favorite added successfully");
    } catch (e) {
      print("Error adding favorite: $e");
    }
  }

  Future<void> updateFavorite(String id, FavoriteModel favorite) async {
    try {
      print("Updating favorite: ${favorite.toJson()}"); // Debug statement
      await collection.doc(id).update(favorite.toJson());
      print("Favorite updated successfully");
    } catch (e) {
      print("Error updating favorite: $e");
    }
  }

  Future<void> deleteFavorite(String id) async {
    try {
      print("Deleting favorite with ID: $id"); // Debug statement
      await collection.doc(id).delete();
      print("Favorite deleted successfully");
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

  // Function to fetch all FavoriteModel items
  Future<List<FavoriteModel>> fetchAllFavorites() async {
    try {
      final querySnapshot = await collection.get();
      List<FavoriteModel> favorites = await Future.wait(
        querySnapshot.docs.map((doc) async {
          return await FavoriteModel.fromSnapshot(doc);
        }).toList()
      );
      return favorites;
    } catch (e) {
      print("Error fetching favorites: $e");
      return [];
    }
  }

  Future<String?> getFavoriteDocumentIdByItemId(String itemId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Favorites')
          .where('itemID', isEqualTo: itemId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id; // Get the document ID
      } else {
        print("No favorite found with itemID: $itemId");
        return null;
      }
    } catch (e) {
      print("Error fetching favorite document ID: $e");
      return null;
    }
  }
}
