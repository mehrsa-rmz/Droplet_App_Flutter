import 'package:get/get.dart';
import '../../../data/repositories/product_repository.dart';
import '../models/favorites_model.dart';

class FavoritesController extends GetxController {
  static FavoritesController get instance => Get.find();

  final ProductRepository _repository = ProductRepository();

  var favorites = <FavoriteModel>[].obs;

  Future<void> fetchFavorites(String customerId) async {
    try {
      final favs = await _repository.fetchFavorites(customerId);
      favorites.assignAll(favs);
    } catch (e) {
      print('Error fetching favorites: $e');
    }
  }

  Future<void> addToFavorites(FavoriteModel favorite) async {
    try {
      await _repository.addToFavorites(favorite);
      fetchFavorites(favorite.customerId);
    } catch (e) {
      print('Error adding to favorites: $e');
    }
  }

  Future<void> removeFromFavorites(String favoriteId) async {
    try {
      await _repository.removeFromFavorites(favoriteId);
      fetchFavorites(favorites.firstWhere((fav) => fav.id == favoriteId).customerId);
    } catch (e) {
      print('Error removing from favorites: $e');
    }
  }
}
