import 'package:flutter_application/features/products/models/product_model.dart';
import 'package:flutter_application/features/profile/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteModel {
  final String id;
  final UserModel user;
  final ProductModel product;

  FavoriteModel({
    required this.id,
    required this.user,
    required this.product
  });

  String get customerId => user.id;

  static FavoriteModel empty() => FavoriteModel(id: '', user: UserModel.empty(), product: ProductModel.empty());
  
  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'itemID': id,
      'customerId': user.id,
      'productId': product.id,
    };
  }

  // Create a model from Firebase document
  static Future<FavoriteModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    if (document.data() != null) {
      final data = document.data()!;
      final userId = data['customerId'] as String;
      final productId = data['productId'] as String;
      // Fetch user document
      final userDoc = await FirebaseFirestore.instance
          .collection('Customers')
          .doc(userId)
          .get();
      final user = UserModel.fromSnapshot(userDoc);

      // Fetch product document
      final productDoc = await FirebaseFirestore.instance
          .collection('Products')
          .doc(productId)
          .get();
      final product = ProductModel.fromSnapshot(productDoc);

      return FavoriteModel(
        id: document.id,
        user: user,
        product: product
        );
    } else {
      return FavoriteModel.empty();
    }
  }
}
