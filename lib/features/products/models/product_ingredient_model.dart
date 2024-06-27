import 'package:cloud_firestore/cloud_firestore.dart';

class ProductIngredientModel {
  final String id;
  final String productId;
  final String ingredientId;

  ProductIngredientModel({
    required this.id,
    required this.productId,
    required this.ingredientId,
  });

  static ProductIngredientModel empty() => ProductIngredientModel(
        id: '',
        productId: '',
        ingredientId: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'ingredientId': ingredientId,
    };
  }

  static Future<ProductIngredientModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    final data = document.data()!;
    return ProductIngredientModel(
      id: document.id,
      productId: data['productId'] as String? ?? '',
      ingredientId: data['ingredientId'] as String? ?? '',
    );
  }
}
