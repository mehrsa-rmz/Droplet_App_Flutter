import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String name;
  final String category;
  final String gender;
  final String ageGroup;
  final bool isHypoallergenic;
  final double price;
  final int promotion;
  int stock;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.gender,
    required this.ageGroup,
    required this.isHypoallergenic,
    required this.price,
    required this.promotion,
    required this.stock,
  });

  /// Create Empty func for clean code
  static ProductModel empty() => ProductModel(id: '', name: '', category: 'all', gender: 'all', ageGroup: 'all', isHypoallergenic: false, price: 0, promotion: 0, stock: 0);

  /// Json Format
  toJson() {
    return {
      'itemID': id,
      'productName': name,
      'productCategory': category,
      'productSpecificGender': gender,
      'productSpecificAge': ageGroup,
      'isHypoallergenic': isHypoallergenic,
      'productPrice': price,
      'productSpecificPromotion': promotion,
      'productStock': stock,
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ProductModel(
      id: document.id,
      name: data['productName'] as String,
      category: data['category'] as String,
      gender: data['productSpecificGender'] as String,
      ageGroup: data['productSpecificAge'] as String,
      isHypoallergenic: data['isHypoallergenic'] as bool,
      price: data['productPrice'] as double,
      promotion: data['productSpecificPromotion'] as int,
      stock: data['productStock'] as int,
    );
  }

  // Map Json-oriented document snapshot from Firebase to Model
  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      name: data['productName'] as String,
      category: data['category'] as String,
      gender: data['productSpecificGender'] as String,
      ageGroup: data['productSpecificAge'] as String,
      isHypoallergenic: data['isHypoallergenic'] as bool,
      price: data['productPrice'] as double,
      promotion: data['productSpecificPromotion'] as int,
      stock: data['productStock'] as int,
    );
  }
}
