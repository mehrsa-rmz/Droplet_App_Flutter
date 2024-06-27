import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/specialist_model.dart';

class SpecialistController extends GetxController {
  static SpecialistController get instance => Get.put(SpecialistController());

  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('Specialists');

  RxList<SpecialistModel> specialists = RxList<SpecialistModel>();

  @override
  void onInit() {
    super.onInit();
    bindSpecialists();
  }

  Future<void> addSpecialist(SpecialistModel specialist) async {
    try {
      await collection.add(specialist.toJson());
    } catch (e) {
      print("Error adding specialist: $e");
    }
  }

  Future<void> updateSpecialist(String id, SpecialistModel specialist) async {
    try {
      await collection.doc(id).update(specialist.toJson());
    } catch (e) {
      print("Error updating specialist: $e");
    }
  }

  Future<void> deleteSpecialist(String id) async {
    try {
      await collection.doc(id).delete();
    } catch (e) {
      print("Error deleting specialist: $e");
    }
  }

  void bindSpecialists() {
    collection.snapshots().listen((snapshot) async {
      List<SpecialistModel> prodModels = await Future.wait(snapshot.docs.map((doc) async {
        return SpecialistModel.fromSnapshot(doc);
      }).toList());
      specialists.assignAll(prodModels);
    });
  }

  // Function to fetch all SpecialistModel items
  Future<List<SpecialistModel>> fetchAllSpecialists() async {
    try {
      final querySnapshot = await collection.get();
      List<SpecialistModel> specialists = await Future.wait(
        querySnapshot.docs.map((doc) async {
          return SpecialistModel.fromSnapshot(doc);
        }).toList()
      );
      return specialists;
    } catch (e) {
      print("Error fetching specialists: $e");
      return [];
    }
  }

  Future<SpecialistModel?> getSpecialistById(String id) async {
    try {
      final documentSnapshot = await collection.doc(id).get();
      if (documentSnapshot.exists) {
        return SpecialistModel.fromSnapshot(documentSnapshot);
      }
    } catch (e) {
      print("Error fetching specialist: $e");
    }
    return null;
  }

}
