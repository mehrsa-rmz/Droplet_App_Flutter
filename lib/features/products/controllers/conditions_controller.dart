import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/condition_model.dart';

class ConditionController extends GetxController {
  static ConditionController get instance => Get.put(ConditionController());

  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('Conditions');

  RxList<ConditionModel> conditions = RxList<ConditionModel>();

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

  Future<List<ConditionModel>> getConditions() async {
    try {
      final querySnapshot = await collection.get();
      List<ConditionModel> conditions = await Future.wait(
        querySnapshot.docs.map((doc) async {
          return ConditionModel.fromSnapshot(doc);
        }).toList()
      );
      return conditions;
    } catch (e) {
      print("Error fetching conditions: $e");
      return [];
    }
  }

  Future<ConditionModel?> getConditionById(String id) async {
    try {
      final documentSnapshot = await collection.doc(id).get();
      if (documentSnapshot.exists) {
        return ConditionModel.fromSnapshot(documentSnapshot);
      }
    } catch (e) {
      print("Error fetching condition: $e");
    }
    return null;
  }
}
