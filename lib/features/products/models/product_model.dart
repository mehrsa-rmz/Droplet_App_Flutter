// import 'package:cloud_firestore/cloud_firestore.dart';

// class ProductModel {
//   final String id;
//   final String name;
//   final String category;
//   final String gender;
//   final String ageGroup;
//   final bool isHypoallergenic;
//   final double price;
//   final int promotion;
//   int stock;

//   ProductModel({
//     required this.id,
//     required this.name,
//     required this.category,
//     required this.gender,
//     required this.ageGroup,
//     required this.isHypoallergenic,
//     required this.price,
//     required this.promotion,
//     required this.stock,
//   });

//   /// Create Empty func for clean code
//   static ProductModel empty() => ProductModel(id: '', name: '', category: 'all', gender: 'all', ageGroup: 'all', isHypoallergenic: false, price: 0, promotion: 0, stock: 0);

//   String getId(){
//     return id.toString();
//   }

//   String getName(){
//     return name.toString();
//   }

//   String getCategory(){
//     return category.toString();
//   }

//   String getGender(){
//     return gender.toString();
//   }
  
//   String getAgeGroup(){
//     return ageGroup.toString();
//   }

//   bool getIsHypoallergenic(){
//     return isHypoallergenic;
//   }

//   double getPrice(){
//     return price;
//   }

//   int getPromotion(){
//     return promotion;
//   }

//   int getStock(){
//     return stock;
//   }

//   bool getIsOutOfStock(){
//     return stock == 0;
//   }

//   /// Json Format
//   Map<String, dynamic> toJson() {
//     return {
//       'itemID': id,
//       'productName': name,
//       'productCategory': category,
//       'productSpecificGender': gender,
//       'productSpecificAge': ageGroup,
//       'isHypoallergenic': isHypoallergenic,
//       'productPrice': price,
//       'productSpecificPromotion': promotion,
//       'productStock': stock,
//     };
//   }

//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: json['itemID'],
//       name: json['productName'] as String,
//       category: json['category'] as String,
//       gender: json['productSpecificGender'] as String,
//       ageGroup: json['productSpecificAge'] as String,
//       isHypoallergenic: json['isHypoallergenic'] as bool,
//       price: json['productPrice'] as double,
//       promotion: json['productSpecificPromotion'] as int,
//       stock: json['productStock'] as int,
//     );
//   }

//   /// Map Json oriented document snapshot from Firebase to Model
//   factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
//     final data = document.data() as Map<String, dynamic>;
//     return ProductModel(
//       id: document.id,
//       name: data['productName'] as String,
//       category: data['category'] as String,
//       gender: data['productSpecificGender'] as String,
//       ageGroup: data['productSpecificAge'] as String,
//       isHypoallergenic: data['isHypoallergenic'] as bool,
//       price: data['productPrice'] as double,
//       promotion: data['productSpecificPromotion'] as int,
//       stock: data['productStock'] as int,
//     );
//   }

//   // Map Json-oriented document snapshot from Firebase to Model
//   factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
//     final data = document.data() as Map<String, dynamic>;
//     return ProductModel(
//       id: document.id,
//       name: data['productName'] as String,
//       category: data['category'] as String,
//       gender: data['productSpecificGender'] as String,
//       ageGroup: data['productSpecificAge'] as String,
//       isHypoallergenic: data['isHypoallergenic'] as bool,
//       price: data['productPrice'] as double,
//       promotion: data['productSpecificPromotion'] as int,
//       stock: data['productStock'] as int,
//     );
//   }
// }

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
