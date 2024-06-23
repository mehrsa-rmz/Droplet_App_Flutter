import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/features/order/models/added_promotion_model.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'cart_item_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final String address;
  OrderStatus shipmentStatus;
  final DateTime orderDate;
  DateTime? deliveryDate;
  StoreLocations? storePickUpLocation;
  final DeliveryMethods deliveryMethod;
  final PaymentMethods paymentMethod;
  final double totalAmount;
  final double totalPoints;
  final List<CartItemModel> items;
  List<AddedPromotionModel>? addedPromotions = [];

  OrderModel({
    required this.id,
    this.userId = '',
    required this.address,
    required this.shipmentStatus,
    required this.orderDate,
    this.deliveryDate,
    this.storePickUpLocation,
    required this.deliveryMethod,
    required this.paymentMethod,
    required this.totalAmount,
    required this.totalPoints,
    required this.items,
    this.addedPromotions,
  });

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null ? THelperFunctions.getFormattedDate(deliveryDate!) : '-';

  String get orderStatusText => shipmentStatus == OrderStatus.delivered
      ? 'Delivered'
      : shipmentStatus == OrderStatus.shipped
          ? 'Shipment on the way'
          : shipmentStatus == OrderStatus.cancelled
            ? 'Order cancelled'
            : shipmentStatus == OrderStatus.returned
              ? 'Order returned'
              : 'Processing';

  String get deliveryMethodText => deliveryMethod == DeliveryMethods.pickUpInStore
      ? 'Pick-up in store'
      : deliveryMethod == DeliveryMethods.standard
          ? 'Standard delivery (3-5 days)'
          : 'Fast delivery (under 24h)  ';

  String get paymentMethodText => paymentMethod == PaymentMethods.cashOnArrival
      ? 'Cash on arrival'
      : paymentMethod == PaymentMethods.cardOnArrival
          ? 'Card on arrival'
          : paymentMethod == PaymentMethods.cardOnline
            ? 'Card online'
            : 'Google or Apple Pay';

  String get storePickUpLocationText {
    switch (storePickUpLocation) {
      case StoreLocations.afi: return 'AFI Palace Mall';
      case StoreLocations.baneasa: return 'Baneasa Mall';
      case StoreLocations.mega: return 'Mega Mall';
      case StoreLocations.parklake: return 'ParkLake Mall';
      case StoreLocations.plaza: return 'Plaza Romania Mall';
      case StoreLocations.promenada: return 'Promenada Mall';
      case StoreLocations.sun: return 'Sun Plaza Mall';
      case StoreLocations.unirii: return 'Unirii Shopping Center';
      case StoreLocations.online: return 'Online';
      case null: return '';
    }
  }
  
  Map<String, dynamic> toJson() {
    return {
      'orderId': id,
      'customerId': userId,
      'address': address,
      'shipmentStatus': shipmentStatus.toString(), // Enum to string
      'orderDate': orderDate,
      'deliveryDate': deliveryDate,
      'storePickUpLocation': storePickUpLocation.toString(),
      'deliveryMethod': deliveryMethod.toString(),
      'paymentMethod': paymentMethod.toString(),
      'totalAmount': totalAmount,
      'items': items.map((item) => item.toJson()).toList(), // Convert CartItemModel to map
      'appliedPromotions': addedPromotions?.map((appliedPromotion) => appliedPromotion.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
      id: data['id'] as String,
      userId: data['userId'] as String,
      address: data['address'] as String,
      shipmentStatus: OrderStatus.values.firstWhere((e) => e.toString() == data['shipmentStatus']),
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      deliveryDate: data['deliveryDate'] == null ? null : (data['deliveryDate'] as Timestamp).toDate(),
      storePickUpLocation: data['storePickUpLocation'] == null ? null : StoreLocations.values.firstWhere((e) => e.toString() == data['storePickUpLocation']),
      deliveryMethod: DeliveryMethods.values.firstWhere((e) => e.toString() == data['deliveryMethod']),
      paymentMethod: PaymentMethods.values.firstWhere((e) => e.toString() == data['paymentMethod']),
      totalAmount: data['totalAmount'] as double,
      totalPoints: data['totalPoints'] as double,
      items: (data['items'] as List<dynamic>).map((itemData) => CartItemModel.fromJson(itemData as Map<String, dynamic>)).toList(),
      addedPromotions: (data['appliedPromotions'] as List<dynamic>).map((itemData) => AddedPromotionModel.fromJson(itemData as Map<String, dynamic>)).toList(),
    );
  }
}
