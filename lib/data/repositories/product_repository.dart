import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/utils/exceptions/firebase_exceptions.dart';
import 'package:flutter_application/utils/exceptions/format_exceptions.dart';
import 'package:get/get.dart';
import '../../features/products/models/favorites_model.dart';
import '../../features/products/models/product_condition_model.dart';
import '../../features/products/models/product_ingredient_model.dart';
import '../../features/products/models/product_model.dart';
import '../../features/products/models/product_review_model.dart';
import '../../utils/exceptions/platform_exceptions.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<ProductModel> fetchProductDetails(String productId) async {
    try {
      final documentSnapshot = await _db.collection("Products").doc(productId).get();
      if (documentSnapshot.exists) {
        return ProductModel.fromSnapshot(documentSnapshot);
      } else {
        return ProductModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductConditionModel>> fetchProductConditions(String productId) async {
    try {
      final querySnapshot = await _db.collection("ProductsConditions")
          .where("productId", isEqualTo: productId).get();
      final productConditionModels = await Future.wait(querySnapshot.docs.map((doc) async => ProductConditionModel.fromSnapshot(doc)));
      return productConditionModels;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductIngredientModel>> fetchProductIngredients(String productId) async {
    try {
      final querySnapshot = await _db.collection("ProductsIngredients")
          .where("productId", isEqualTo: productId).get();
      final productIngredientModels = await Future.wait(querySnapshot.docs.map((doc) async => ProductIngredientModel.fromSnapshot(doc)));
      return productIngredientModels;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductReviewModel>> fetchProductReviews(String productId) async {
    try {
      final querySnapshot = await _db.collection("ProductReviews")
          .where("productId", isEqualTo: productId).get();
      final productReviewModels = await Future.wait(querySnapshot.docs.map((doc) async => ProductReviewModel.fromSnapshot(doc)));
      return productReviewModels;    
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<FavoriteModel>> fetchFavorites(String customerId) async {
    try {
      final querySnapshot = await _db.collection("Favorites")
          .where("customerId", isEqualTo: customerId).get();
      final favoriteModels = await Future.wait(querySnapshot.docs.map((doc) async => FavoriteModel.fromSnapshot(doc)));
      return favoriteModels;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Add a product review
  Future<void> addProductReview(ProductReviewModel review) async {
    try {
      await _db.collection("ProductReviews").add(review.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Add a product to favorites
  Future<void> addToFavorites(FavoriteModel favorite) async {
    try {
      await _db.collection("Favorites").add(favorite.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Remove a product from favorites
  Future<void> removeFromFavorites(String favoriteId) async {
    try {
      await _db.collection("Favorites").doc(favoriteId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}