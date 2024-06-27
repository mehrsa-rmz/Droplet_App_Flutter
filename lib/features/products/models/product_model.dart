import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String category;
  final String gender;
  final String ageGroup;
  final bool isHypoallergenic;
  final String name;
  final int price;
  final int stock;
  final int promotion;

  ProductModel({
    required this.id,
    required this.category,
    required this.gender,
    required this.ageGroup,
    required this.isHypoallergenic,
    required this.name,
    required this.price,
    required this.stock,
    required this.promotion,
  });

  static ProductModel empty() => ProductModel(
    id: '',
    category: '',
    gender: '',
    ageGroup: '',
    isHypoallergenic: false,
    name: '',
    price: 0,
    stock: 0,
    promotion: 0,
  );

  Map<String, dynamic> toJson() {
    return {
      'itemID': id,
      'productCategory': category,
      'productSpecificGender': gender,
      'productSpecificAge': ageGroup,
      'isHypoallergenic': isHypoallergenic,
      'productName': name,
      'productPrice': price,
      'productStock': stock,
      'productSpecificPromotion': promotion,
    };
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ProductModel(
        id: document.id,
        category: data['productCategory'] as String,
        gender: data['productSpecificGender'] as String,
        ageGroup: data['productSpecificAge'] as String,
        isHypoallergenic: data['isHypoallergenic'] as bool,
        name: data['productName'] as String,
        price: data['productPrice'] as int,
        stock: data['productStock'] as int,
        promotion: data['productSpecificPromotion'] as int,
      );
    } else {
      return ProductModel.empty();
    }
  }
}
