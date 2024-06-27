import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.put(ProductController());

  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('Products');

  RxList<ProductModel> products = RxList<ProductModel>();

  @override
  void onInit() {
    super.onInit();
    bindProducts();
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await collection.add(product.toJson());
    } catch (e) {
      print("Error adding product: $e");
    }
  }

  Future<void> updateProduct(String id, ProductModel product) async {
    try {
      await collection.doc(id).update(product.toJson());
    } catch (e) {
      print("Error updating product: $e");
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await collection.doc(id).delete();
    } catch (e) {
      print("Error deleting product: $e");
    }
  }

  void bindProducts() {
    collection.snapshots().listen((snapshot) async {
      List<ProductModel> prodModels = await Future.wait(snapshot.docs.map((doc) async {
        return ProductModel.fromSnapshot(doc);
      }).toList());
      products.assignAll(prodModels);
    });
  }

  // Function to fetch all ProductModel items
  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      final querySnapshot = await collection.get();
      List<ProductModel> products = await Future.wait(
        querySnapshot.docs.map((doc) async {
          return ProductModel.fromSnapshot(doc);
        }).toList()
      );
      return products;
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  Future<ProductModel?> getProductById(String id) async {
    try {
      final documentSnapshot = await collection.doc(id).get();
      if (documentSnapshot.exists) {
        return ProductModel.fromSnapshot(documentSnapshot);
      }
    } catch (e) {
      print("Error fetching product: $e");
    }
    return null;
  }

}
