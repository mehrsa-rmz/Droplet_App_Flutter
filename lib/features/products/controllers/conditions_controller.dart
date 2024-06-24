import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/condition_model.dart';

class ConditionController extends GetxController {
  static ConditionController get instance => Get.find();

  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('Conditions');

  RxList<ConditionModel> conditions = RxList<ConditionModel>();

  @override
  void onInit() {
    super.onInit();
    conditions.bindStream(getConditions());
  }

  Future<void> addCondition(ConditionModel condition) async {
    try {
      await collection.add(condition.toJson());
    } catch (e) {
      print("Error adding condition: $e");
    }
  }

  Future<void> updateCondition(String id, ConditionModel condition) async {
    try {
      await collection.doc(id).update(condition.toJson());
    } catch (e) {
      print("Error updating condition: $e");
    }
  }

  Future<void> deleteCondition(String id) async {
    try {
      await collection.doc(id).delete();
    } catch (e) {
      print("Error deleting condition: $e");
    }
  }

  Stream<List<ConditionModel>> getConditions() {
    return collection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ConditionModel.fromSnapshot(doc))
          .toList();
    });
  }
}
