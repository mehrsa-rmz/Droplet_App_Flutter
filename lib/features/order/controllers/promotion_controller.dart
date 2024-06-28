import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/promotion_model.dart';

class PromotionController extends GetxController {
  static PromotionController get instance => Get.put(PromotionController());

  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('Promotions');

  RxList<PromotionModel> promotions = RxList<PromotionModel>();

  Future<void> addPromotion(PromotionModel promotion) async {
    try {
      await collection.add(promotion.toJson());
    } catch (e) {
      print("Error adding promotion: $e");
    }
  }

  Future<void> updatePromotion(String id, PromotionModel promotion) async {
    try {
      await collection.doc(id).update(promotion.toJson());
    } catch (e) {
      print("Error updating promotion: $e");
    }
  }

  Future<void> deletePromotion(String id) async {
    try {
      await collection.doc(id).delete();
    } catch (e) {
      print("Error deleting promotion: $e");
    }
  }

  Future<List<PromotionModel>> getPromotions() async {
    try {
      final querySnapshot = await collection.get();
      List<PromotionModel> promotions = await Future.wait(
        querySnapshot.docs.map((doc) async {
          return PromotionModel.fromSnapshot(doc);
        }).toList()
      );
      return promotions;
    } catch (e) {
      print("Error fetching promotions: $e");
      return [];
    }
  }

  Future<PromotionModel?> getPromotionById(String id) async {
    try {
      final documentSnapshot = await collection.doc(id).get();
      if (documentSnapshot.exists) {
        return PromotionModel.fromSnapshot(documentSnapshot);
      }
    } catch (e) {
      print("Error fetching promotion: $e");
    }
    return null;
  }
}
