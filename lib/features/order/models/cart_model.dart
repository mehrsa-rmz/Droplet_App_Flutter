import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String id;
  final String userId;

  CartModel({
    required this.id,
    required this.userId,
  });

  /// Create Empty func for clean code
  static CartModel empty() => CartModel(id: '', userId: '');

  /// Json Format
  toJson() {
    return {
      'itemID': id,
      'customerId': userId,
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  static Future<CartModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    final data = document.data()!;
    return CartModel(
      id: document.id,
      userId: data['customerId'] as String,
    );
  }
}
