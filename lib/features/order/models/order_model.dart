import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String userId;
  final String address;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNo;
  String shipmentStatus;
  final String deliveryMethod;
  final String paymentMethod;
  final String orderDate;
  String deliveryDate;
  String pickupLocation;
  final int points;
  final int finalPrice;

  OrderModel({
    required this.id,
    required this.userId,
    required this.address,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNo,
    required this.shipmentStatus,
    required this.deliveryMethod,
    required this.paymentMethod,
    required this.orderDate,
    required this.deliveryDate,
    required this.pickupLocation,
    required this.points,
    required this.finalPrice
  });

  /// Create Empty func for clean code
  static OrderModel empty() => OrderModel(id: '', userId: '', address: '', firstName: '', lastName: '', email: '', phoneNo: '', shipmentStatus: '', deliveryMethod: '', paymentMethod: '', orderDate: '', deliveryDate: '', pickupLocation: '', points: 0, finalPrice: 0);

  /// Json Format
  toJson() {
    return {
      'itemID': id,
      'customerId': userId,
      'orderAddress': address,
      'customerFirstName': firstName,
      'customerLastName': lastName,
      'customerEmail': email,
      'customerPhoneNo': phoneNo,
      'shipmentStatus': shipmentStatus,
      'deliveryMethod': deliveryMethod,
      'paymentMethod': paymentMethod,
      'orderDate': orderDate,
      'deliveryDate': deliveryDate,
      'pickupLocation': pickupLocation,
      'orderFinalPrice': finalPrice,
      'orderPoints': points
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  static Future<OrderModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    final data = document.data()!;
    return OrderModel(
      id: data['itemID'] as String,
      userId: data['customerId'] as String,
      address: data['orderAddress'] as String,
      firstName: data['customerFirstName'] as String,
      lastName: data['customerLastName'] as String,
      email: data['customerEmail'] as String,
      phoneNo: data['customerPhoneNo'] as String,
      shipmentStatus: data['shipmentStatus'] as String,
      deliveryMethod: data['deliveryMethod'] as String,
      paymentMethod: data['paymentMethod'] as String,
      orderDate: data['orderDate'] as String,
      deliveryDate: data['deliveryDate'] as String,
      pickupLocation: data['pickupLocation'] as String,
      finalPrice: data['orderFinalPrice'] as int,
      points: data['orderPoints'] as int
    );
  }
}
