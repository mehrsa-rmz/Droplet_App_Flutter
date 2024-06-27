import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/features/order/models/promotion_order_model.dart';
import 'package:get/get.dart';

class PromotionOrderController extends GetxController {
  static PromotionOrderController get instance => Get.put(PromotionOrderController());

  final CollectionReference<Map<String, dynamic>> collection =
    FirebaseFirestore.instance.collection('PromotionsOrders');
  
    RxList<PromotionOrderModel> orderPromotions = RxList<PromotionOrderModel>();


  @override
  void onInit() {
    super.onInit();
    bindOrderPromotions();
  }

  // Function to fetch the current user's promotion items
  Future<List<PromotionOrderModel>> fetchOrderPromotionsForOrderId(String orderId) async {
    try {
      final querySnapshot = await collection
          .where('orderId', isEqualTo: orderId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        List<PromotionOrderModel> promotions = await Future.wait(
          querySnapshot.docs.map((doc) async {
            return await PromotionOrderModel.fromSnapshot(doc);
          }).toList()
        );
        orderPromotions.assignAll(promotions);
        return promotions;
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching promotions: $e");
      return [];
    }
  }

  Future<void> addOrderPromotion(PromotionOrderModel promotion) async {
    try {
      print("Adding promotion: ${promotion.toJson()}"); // Debug statement
      await collection.add(promotion.toJson());
      print("Promotion added successfully");
    } catch (e) {
      print("Error adding promotion: $e");
    }
  }

  Future<void> updateOrderPromotion(String id, PromotionOrderModel promotion) async {
    try {
      print("Updating promotion: ${promotion.toJson()}"); // Debug statement
      await collection.doc(id).update(promotion.toJson());
      print("Promotion updated successfully");
    } catch (e) {
      print("Error updating promotion: $e");
    }
  }

  Future<void> deleteOrderPromotion(String id) async {
    try {
      print("Deleting promotion with ID: $id"); // Debug statement
      await collection.doc(id).delete();
      print("Promotion deleted successfully");
    } catch (e) {
      print("Error deleting promotion: $e");
    }
  }

  void bindOrderPromotions() {
    collection.snapshots().listen((snapshot) async {
      List<PromotionOrderModel> promos = await Future.wait(snapshot.docs.map((doc) async {
        return await PromotionOrderModel.fromSnapshot(doc);
      }).toList());
      orderPromotions.assignAll(promos);
    });
  }

  // Function to fetch all PromotionOrderModel items
  Future<List<PromotionOrderModel>> fetchAllOrderPromotions() async {
    try {
      final querySnapshot = await collection.get();
      List<PromotionOrderModel> promotions = await Future.wait(
        querySnapshot.docs.map((doc) async {
          return await PromotionOrderModel.fromSnapshot(doc);
        }).toList()
      );
      return promotions;
    } catch (e) {
      print("Error fetching promotions: $e");
      return [];
    }
  }

  Future<String?> getOrderPromotionDocumentIdByItemId(String itemId) async {
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
