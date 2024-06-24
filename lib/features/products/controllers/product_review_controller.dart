import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/product_review_model.dart';

class ProductReviewController extends GetxController {
  static ProductReviewController get instance => Get.find();

  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('ProductReviews');

  RxList<ProductReviewModel> productReviews = RxList<ProductReviewModel>();

  @override
  void onInit() {
    super.onInit();
    bindProductReviews();
  }

  Future<void> addProductReview(ProductReviewModel productReview) async {
    try {
      await collection.add(productReview.toJson());
    } catch (e) {
      print("Error adding product review: $e");
    }
  }

  Future<void> updateProductReview(String id, ProductReviewModel productReview) async {
    try {
      await collection.doc(id).update(productReview.toJson());
    } catch (e) {
      print("Error updating product review: $e");
    }
  }

  Future<void> deleteProductReview(String id) async {
    try {
      await collection.doc(id).delete();
    } catch (e) {
      print("Error deleting product review: $e");
    }
  }

  void bindProductReviews() {
    collection.snapshots().listen((snapshot) async {
      List<ProductReviewModel> prModels = await Future.wait(snapshot.docs.map((doc) async {
        return await ProductReviewModel.fromSnapshot(doc);
      }).toList());
      productReviews.assignAll(prModels);
    });
  }
}
