import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/features/profile/models/user_model.dart';

class OrderModel {
  final String id;
  final UserModel user;
  final String address;
  String shipmentStatus;
  final String deliveryMethod;
  final String paymentMethod;

  OrderModel({
    required this.id,
    required this.user,
    required this.address,
    required this.shipmentStatus,
    required this.deliveryMethod,
    required this.paymentMethod
  });

  /// Create Empty func for clean code
  static OrderModel empty() => OrderModel(id: '', user: UserModel.empty(), address: '', shipmentStatus: '', deliveryMethod: '', paymentMethod: '');

  /// Json Format
  toJson() {
    return {
      'itemID': id,
      'customerId': user.id,
      'orderAddress': address,
      'shipmentStatus': shipmentStatus,
      'deliveryMethod': deliveryMethod,
      'paymentMethod': paymentMethod
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  static Future<OrderModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    final data = document.data()!;
    final userId = data['customerId'] as String;
    // Fetch user document
    final userDoc = await FirebaseFirestore.instance
        .collection('Customers')
        .doc(userId)
        .get();
    final user = UserModel.fromSnapshot(userDoc);
    return OrderModel(
      id: document.id,
      user: user,
      address: data['orderAddress'] as String,
      shipmentStatus: data['shipmentStatus'] as String,
      deliveryMethod: data['deliveryMethod'] as String,
      paymentMethod: data['paymentMethod'] as String
    );
  }
}
