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
  int reviewsNo;
  double rating;
  bool favorite;
  bool outOfStock;

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
    required this.reviewsNo,
    required this.rating,
    required this.favorite,
    required this.outOfStock,
  });

  get noOfOrders => null;

  static ProductModel empty() => ProductModel(
      id: '',
      name: '',
      category: 'all',
      gender: 'all',
      ageGroup: 'all',
      isHypoallergenic: false,
      price: 0,
      promotion: 0,
      stock: 0,
      reviewsNo: 0,
      rating: 0.0,
      favorite: false,
      outOfStock: false);

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
      'productReviewsNo': reviewsNo,
      'productRating': rating,
      'productFavorite': favorite,
      'productOutOfStock': outOfStock,
    };
  }

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
      reviewsNo: data['productReviewsNo'] as int,
      rating: data['productRating'] as double,
      favorite: data['productFavorite'] as bool,
      outOfStock: data['productOutOfStock'] as bool,
    );
  }

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
      reviewsNo: data['productReviewsNo'] as int,
      rating: data['productRating'] as double,
      favorite: data['productFavorite'] as bool,
      outOfStock: data['productOutOfStock'] as bool,
    );
  }

  where(bool Function(dynamic product) param0) {}
}
