import 'package:cloud_firestore/cloud_firestore.dart';

class ProductConditionModel {
  final String id;
  final String productId;
  final String conditionId;

  ProductConditionModel({
    required this.id,
    required this.productId,
    required this.conditionId,
  });

  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return {
      'itemID': id,
      'productId': productId,
      'conditionId': conditionId,
    };
  }

  // Create a ProductConditionModel from Firebase document
  static Future<ProductConditionModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    final data = document.data()!;
    return ProductConditionModel(
      id: document.id,
      productId: data['productId'] ?? '',
      conditionId: data['conditionId'] ?? '',
    );
  }

  // Create an empty instance
  static ProductConditionModel empty() => ProductConditionModel(id: '', productId: '', conditionId: '');
}
