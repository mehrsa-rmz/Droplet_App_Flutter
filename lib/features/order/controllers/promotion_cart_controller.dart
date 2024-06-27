import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/features/order/models/promotion_cart_model.dart';
import 'package:get/get.dart';

class PromotionCartController extends GetxController {
  static PromotionCartController get instance => Get.put(PromotionCartController());

  final CollectionReference<Map<String, dynamic>> collection =
    FirebaseFirestore.instance.collection('PromotionsCarts');
  
    RxList<PromotionCartModel> cartPromotions = RxList<PromotionCartModel>();


  @override
  void onInit() {
    super.onInit();
    bindCartPromotions();
  }

  // Function to fetch the current user's promotion items
  Future<List<PromotionCartModel>> fetchCartPromotionsForCartId(String cartId) async {
    try {
      final querySnapshot = await collection
          .where('cartId', isEqualTo: cartId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        List<PromotionCartModel> promotions = await Future.wait(
          querySnapshot.docs.map((doc) async {
            return await PromotionCartModel.fromSnapshot(doc);
          }).toList()
        );
        cartPromotions.assignAll(promotions);
        return promotions;
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching promotions: $e");
      return [];
    }
  }

  Future<void> addCartPromotion(PromotionCartModel promotion) async {
    try {
      print("Adding promotion: ${promotion.toJson()}"); // Debug statement
      await collection.add(promotion.toJson());
      print("Promotion added successfully");
    } catch (e) {
      print("Error adding promotion: $e");
    }
  }

  Future<void> updateCartPromotion(String id, PromotionCartModel promotion) async {
    try {
      print("Updating promotion: ${promotion.toJson()}"); // Debug statement
      await collection.doc(id).update(promotion.toJson());
      print("Promotion updated successfully");
    } catch (e) {
      print("Error updating promotion: $e");
    }
  }

  Future<void> deleteCartPromotion(String id) async {
    try {
      print("Deleting promotion with ID: $id"); // Debug statement
      await collection.doc(id).delete();
      print("Promotion deleted successfully");
    } catch (e) {
      print("Error deleting promotion: $e");
    }
  }

  void bindCartPromotions() {
    collection.snapshots().listen((snapshot) async {
      List<PromotionCartModel> promos = await Future.wait(snapshot.docs.map((doc) async {
        return await PromotionCartModel.fromSnapshot(doc);
      }).toList());
      cartPromotions.assignAll(promos);
    });
  }

  // Function to fetch all PromotionCartModel items
  Future<List<PromotionCartModel>> fetchAllCartPromotions() async {
    try {
      final querySnapshot = await collection.get();
      List<PromotionCartModel> promotions = await Future.wait(
        querySnapshot.docs.map((doc) async {
          return await PromotionCartModel.fromSnapshot(doc);
        }).toList()
      );
      return promotions;
    } catch (e) {
      print("Error fetching promotions: $e");
      return [];
    }
  }

  Future<String?> getCartPromotionDocumentIdByItemId(String itemId) async {
    try {
      final querySnapshot = await collection
          .where('itemID', isEqualTo: itemId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id; // Get the document ID
      } else {
        print("No promotion found with itemID: $itemId");
        return null;
      }
    } catch (e) {
      print("Error fetching promotion document ID: $e");
      return null;
    }
  }
}
