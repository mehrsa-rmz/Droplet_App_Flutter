// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import '../models/product_ingredient_model.dart';

// class ProductIngredientController extends GetxController {
//   static ProductIngredientController get instance => Get.put(ProductIngredientController());

//   final CollectionReference<Map<String, dynamic>> collection =
//       FirebaseFirestore.instance.collection('ProductsIngredients');

//   RxList<ProductIngredientModel> productIngredients = RxList<ProductIngredientModel>();

//   @override
//   void onInit() {
//     super.onInit();
//     bindProductIngredients();
//   }

//   Future<void> addProductIngredient(ProductIngredientModel productIngredient) async {
//     try {
//       await collection.add(productIngredient.toJson());
//     } catch (e) {
//       print("Error adding product ingredient: $e");
//     }
//   }

//   Future<void> updateProductIngredient(String id, ProductIngredientModel productIngredient) async {
//     try {
//       await collection.doc(id).update(productIngredient.toJson());
//     } catch (e) {
//       print("Error updating product ingredient: $e");
//     }
//   }

//   Future<void> deleteProductIngredient(String id) async {
//     try {
//       await collection.doc(id).delete();
//     } catch (e) {
//       print("Error deleting product ingredient: $e");
//     }
//   }

//   // Function to fetch all ProductIngredientModel items
//   Future<List<ProductIngredientModel>> fetchAllProductIngredients() async {
//     try {
//       final querySnapshot = await collection.get();
//       List<ProductIngredientModel> productIngredients = await Future.wait(
//         querySnapshot.docs.map((doc) async {
//           return await ProductIngredientModel.fromSnapshot(doc);
//         }).toList()
//       );
//       return productIngredients;
//     } catch (e) {
//       print("Error fetching product ingredients: $e");
//       return [];
//     }
//   }

//   void bindProductIngredients() {
//     collection.snapshots().listen((snapshot) async {
//       try {
//         List<ProductIngredientModel> piModels = await Future.wait(snapshot.docs.map((doc) async {
//           return await ProductIngredientModel.fromSnapshot(doc);
//         }).toList());
//         productIngredients.assignAll(piModels);
//       } catch (e) {
//         print("Error binding product ingredients: $e");
//       }
//     });
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/product_ingredient_model.dart';

class ProductIngredientController extends GetxController {
  static ProductIngredientController get instance => Get.put(ProductIngredientController());

  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('ProductsIngredients');

  RxList<ProductIngredientModel> productIngredients = RxList<ProductIngredientModel>();

  @override
  void onInit() {
    super.onInit();
    bindProductIngredients();
  }

  Future<void> addProductIngredient(ProductIngredientModel productIngredient) async {
    try {
      await collection.add(productIngredient.toJson());
    } catch (e) {
      print("Error adding product ingredient: $e");
    }
  }

  Future<void> updateProductIngredient(String id, ProductIngredientModel productIngredient) async {
    try {
      await collection.doc(id).update(productIngredient.toJson());
    } catch (e) {
      print("Error updating product ingredient: $e");
    }
  }

  Future<void> deleteProductIngredient(String id) async {
    try {
      await collection.doc(id).delete();
    } catch (e) {
      print("Error deleting product ingredient: $e");
    }
  }

  void bindProductIngredients() {
    collection.snapshots().listen((snapshot) async {
      List<ProductIngredientModel> piModels = await Future.wait(snapshot.docs.map((doc) async {
        return await ProductIngredientModel.fromSnapshot(doc);
      }).toList());
      productIngredients.assignAll(piModels);
    });
  }

  Future<List<ProductIngredientModel>> fetchAllProductIngredients() async {
    try {
      final querySnapshot = await collection.get();
      List<ProductIngredientModel> productIngredients = await Future.wait(
        querySnapshot.docs.map((doc) async {
          return await ProductIngredientModel.fromSnapshot(doc);
        }).toList()
      );
      return productIngredients;
    } catch (e) {
      print("Error fetching product ingredients: $e");
      return [];
    }
  }

  Future<ProductIngredientModel?> getProductById(String id) async {
    try {
      final documentSnapshot = await collection.doc(id).get();
      if (documentSnapshot.exists) {
        return ProductIngredientModel.fromSnapshot(documentSnapshot);
      }
    } catch (e) {
      print("Error fetching product: $e");
    }
    return null;
  }
}
