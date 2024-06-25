// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import '../models/product_condition_model.dart';

// class ProductConditionController extends GetxController {
//   static ProductConditionController get instance => Get.put(ProductConditionController());

//   final CollectionReference<Map<String, dynamic>> collection =
//       FirebaseFirestore.instance.collection('ProductsConditions');

//   RxList<ProductConditionModel> productConditions = RxList<ProductConditionModel>();

//   @override
//   void onInit() {
//     super.onInit();
//     bindProductConditions();
//   }

//   Future<void> addProductCondition(ProductConditionModel productCondition) async {
//     try {
//       await collection.add(productCondition.toJson());
//     } catch (e) {
//       print("Error adding product condition: $e");
//     }
//   }

//   Future<void> updateProductCondition(String id, ProductConditionModel productCondition) async {
//     try {
//       await collection.doc(id).update(productCondition.toJson());
//     } catch (e) {
//       print("Error updating product condition: $e");
//     }
//   }

//   Future<void> deleteProductCondition(String id) async {
//     try {
//       await collection.doc(id).delete();
//     } catch (e) {
//       print("Error deleting product condition: $e");
//     }
//   }

//   void bindProductConditions() {
//     collection.snapshots().listen((snapshot) async {
//       try {
//         List<ProductConditionModel> pcModels = await Future.wait(snapshot.docs.map((doc) async {
//           return await ProductConditionModel.fromSnapshot(doc);
//         }).toList());
//         productConditions.assignAll(pcModels);
//       } catch (e) {
//         print("Error binding product conditions: $e");
//       }
//     });
//   }

//   // Function to fetch all ProductConditionModel items
//   Future<List<ProductConditionModel>> fetchAllProductConditions() async {
//     try {
//       final querySnapshot = await collection.get();
//       List<ProductConditionModel> productConditions = await Future.wait(
//         querySnapshot.docs.map((doc) async {
//           return await ProductConditionModel.fromSnapshot(doc);
//         }).toList()
//       );
//       return productConditions;
//     } catch (e) {
//       print("Error fetching product conditions: $e");
//       return [];
//     }
//   }

//   Future<ProductConditionModel?> getProductById(String id) async {
//     try {
//       final documentSnapshot = await collection.doc(id).get();
//       if (documentSnapshot.exists) {
//         return ProductConditionModel.fromSnapshot(documentSnapshot);
//       }
//     } catch (e) {
//       print("Error fetching product: $e");
//     }
//     return null;
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/product_condition_model.dart';

class ProductConditionController extends GetxController {
  static ProductConditionController get instance => Get.put(ProductConditionController());

  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('ProductsConditions');

  RxList<ProductConditionModel> productConditions = RxList<ProductConditionModel>();

  @override
  void onInit() {
    super.onInit();
    bindProductConditions();
  }

  Future<void> addProductCondition(ProductConditionModel productCondition) async {
    try {
      await collection.add(productCondition.toJson());
    } catch (e) {
      print("Error adding product condition: $e");
    }
  }

  Future<void> updateProductCondition(String id, ProductConditionModel productCondition) async {
    try {
      await collection.doc(id).update(productCondition.toJson());
    } catch (e) {
      print("Error updating product condition: $e");
    }
  }

  Future<void> deleteProductCondition(String id) async {
    try {
      await collection.doc(id).delete();
    } catch (e) {
      print("Error deleting product condition: $e");
    }
  }

  void bindProductConditions() {
    collection.snapshots().listen((snapshot) async {
      try {
        List<ProductConditionModel> pcModels = await Future.wait(snapshot.docs.map((doc) async {
          return await ProductConditionModel.fromSnapshot(doc);
        }).toList());
        productConditions.assignAll(pcModels);
      } catch (e) {
        print("Error binding product conditions: $e");
      }
    });
  }

  // Function to fetch all ProductConditionModel items
  Future<List<ProductConditionModel>> fetchAllProductConditions() async {
    try {
      final querySnapshot = await collection.get();
      List<ProductConditionModel> productConditions = await Future.wait(
        querySnapshot.docs.map((doc) async {
          return await ProductConditionModel.fromSnapshot(doc);
        }).toList()
      );
      return productConditions;
    } catch (e) {
      print("Error fetching product conditions: $e");
      return [];
    }
  }

  Future<ProductConditionModel?> getProductById(String id) async {
    try {
      final documentSnapshot = await collection.doc(id).get();
      if (documentSnapshot.exists) {
        return ProductConditionModel.fromSnapshot(documentSnapshot);
      }
    } catch (e) {
      print("Error fetching product: $e");
    }
    return null;
  }
}
