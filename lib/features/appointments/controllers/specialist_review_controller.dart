import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/specialist_review_model.dart';

class SpecialistReviewController extends GetxController {
  static SpecialistReviewController get instance => Get.put(SpecialistReviewController());

  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('SpecialistsReviews');

  RxList<SpecialistReviewModel> specialistReviews = RxList<SpecialistReviewModel>();

  @override
  void onInit() {
    super.onInit();
    bindSpecialistsReviews();
  }

  Future<void> addSpecialistReview(SpecialistReviewModel specialistReview) async {
    try {
      await collection.add(specialistReview.toJson());
    } catch (e) {
      print("Error adding specialist review: $e");
    }
  }

  Future<void> updateSpecialistReview(String id, SpecialistReviewModel specialistReview) async {
    try {
      await collection.doc(id).update(specialistReview.toJson());
    } catch (e) {
      print("Error updating specialist review: $e");
    }
  }

  Future<void> deleteSpecialistReview(String id) async {
    try {
      await collection.doc(id).delete();
    } catch (e) {
      print("Error deleting specialist review: $e");
    }
  }

  void bindSpecialistsReviews() {
    collection.snapshots().listen((snapshot) async {
      List<SpecialistReviewModel> prModels = await Future.wait(snapshot.docs.map((doc) async {
        return await SpecialistReviewModel.fromSnapshot(doc);
      }).toList());
      specialistReviews.assignAll(prModels);
    });
  }

  // Function to fetch all SpecialistReviewModel items
  Future<List<SpecialistReviewModel>> fetchAllSpecialistsReviews() async {
    try {
      final querySnapshot = await collection.get();
      List<SpecialistReviewModel> specialistReviews = await Future.wait(
        querySnapshot.docs.map((doc) async {
          return await SpecialistReviewModel.fromSnapshot(doc);
        }).toList()
      );
      return specialistReviews;
    } catch (e) {
      print("Error fetching specialist reviews: $e");
      return [];
    }
  }
}
