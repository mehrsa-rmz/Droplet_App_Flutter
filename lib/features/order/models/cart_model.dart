import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/features/profile/models/user_model.dart';

class CartModel {
  final String id;
  final UserModel user;

  CartModel({
    required this.id,
    required this.user,
  });

  /// Create Empty func for clean code
  static CartModel empty() => CartModel(id: '', user: UserModel.empty());

  /// Json Format
  toJson() {
    return {
      'itemID': id,
      'customerId': user.id,
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  static Future<CartModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    final data = document.data()!;
    final userId = data['customerId'] as String;
    // Fetch user document
    final userDoc = await FirebaseFirestore.instance
        .collection('Customers')
        .doc(userId)
        .get();
    final user = UserModel.fromSnapshot(userDoc);
    return CartModel(
      id: document.id,
      user: user,
    );
  }
}
