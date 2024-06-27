import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/features/profile/models/user_allergy_model.dart';
import 'package:get/get.dart';

class UserAllergyController extends GetxController {
  static UserAllergyController get instance => Get.put(UserAllergyController());

  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('CustomersAllergies');

  RxList<UserAllergyModel> userAllergies = RxList<UserAllergyModel>();

  @override
  void onInit() {
    super.onInit();
    bindUserAllergies();
  }

  Future<void> addUserAllergy(UserAllergyModel userAllergy) async {
    try {
      await collection.add(userAllergy.toJson());
    } catch (e) {
      print("Error adding user allergy: $e");
    }
  }

  Future<void> updateUserAllergy(String id, UserAllergyModel userAllergy) async {
    try {
      await collection.doc(id).update(userAllergy.toJson());
    } catch (e) {
      print("Error updating user allergy: $e");
    }
  }

  Future<void> deleteUserAllergy(String id) async {
    try {
      await collection.doc(id).delete();
    } catch (e) {
      print("Error deleting user allergy: $e");
    }
  }

  void bindUserAllergies() {
    collection.snapshots().listen((snapshot) async {
      List<UserAllergyModel> uaModels = await Future.wait(snapshot.docs.map((doc) async {
        return await UserAllergyModel.fromSnapshot(doc);
      }).toList());
      userAllergies.assignAll(uaModels);
    });
  }

  Future<List<UserAllergyModel>> fetchAllUserAllergies() async {
    try {
      final querySnapshot = await collection.get();
      List<UserAllergyModel> userAllergies = await Future.wait(
        querySnapshot.docs.map((doc) async {
          return await UserAllergyModel.fromSnapshot(doc);
        }).toList()
      );
      return userAllergies;
    } catch (e) {
      print("Error fetching users allergies: $e");
      return [];
    }
  }

  Future<UserAllergyModel?> getUserAllergyById(String id) async {
    try {
      final documentSnapshot = await collection.doc(id).get();
      if (documentSnapshot.exists) {
        return UserAllergyModel.fromSnapshot(documentSnapshot);
      }
    } catch (e) {
      print("Error fetching user allergy: $e");
    }
    return null;
  }
}
