import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/features/profile/models/user_condition_model.dart';
import 'package:get/get.dart';

class UserConditionController extends GetxController {
  static UserConditionController get instance => Get.put(UserConditionController());

  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('CustomersConditions');

  RxList<UserConditionModel> userConditions = RxList<UserConditionModel>();

  @override
  void onInit() {
    super.onInit();
    bindUserConditions();
  }

  Future<void> addUserCondition(UserConditionModel userCondition) async {
    try {
      await collection.add(userCondition.toJson());
    } catch (e) {
      print("Error adding user condition: $e");
    }
  }

  Future<void> updateUserCondition(String id, UserConditionModel userCondition) async {
    try {
      await collection.doc(id).update(userCondition.toJson());
    } catch (e) {
      print("Error updating user condition: $e");
    }
  }

  Future<void> deleteUserCondition(String id) async {
    try {
      await collection.doc(id).delete();
    } catch (e) {
      print("Error deleting user condition: $e");
    }
  }

  void bindUserConditions() {
    collection.snapshots().listen((snapshot) async {
      try {
        List<UserConditionModel> ucModels = await Future.wait(snapshot.docs.map((doc) async {
          return await UserConditionModel.fromSnapshot(doc);
        }).toList());
        userConditions.assignAll(ucModels);
      } catch (e) {
        print("Error binding user conditions: $e");
      }
    });
  }

  // Function to fetch all UserConditionModel items
  Future<List<UserConditionModel>> fetchAllUserConditions() async {
    try {
      final querySnapshot = await collection.get();
      List<UserConditionModel> userConditions = await Future.wait(
        querySnapshot.docs.map((doc) async {
          return await UserConditionModel.fromSnapshot(doc);
        }).toList()
      );
      return userConditions;
    } catch (e) {
      print("Error fetching users conditions: $e");
      return [];
    }
  }

  Future<UserConditionModel?> getUserConditionById(String id) async {
    try {
      final documentSnapshot = await collection.doc(id).get();
      if (documentSnapshot.exists) {
        return UserConditionModel.fromSnapshot(documentSnapshot);
      }
    } catch (e) {
      print("Error fetching user condition: $e");
    }
    return null;
  }
}
