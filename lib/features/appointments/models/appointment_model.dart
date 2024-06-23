import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/utils/constants/enums.dart';

class AppointmentModel {
  final String id;
  final String specialistId;
  final String userId;
  final DateTime timestamp;
  final StoreLocations location;

  AppointmentModel({
    required this.id,
    required this.specialistId,
    required this.userId,
    required this.timestamp,
    required this.location
  });

  String get locationText {
    switch (location) {
      case StoreLocations.afi: return 'AFI Palace Mall';
      case StoreLocations.baneasa: return 'Baneasa Mall';
      case StoreLocations.mega: return 'Mega Mall';
      case StoreLocations.parklake: return 'ParkLake Mall';
      case StoreLocations.plaza: return 'Plaza Romania Mall';
      case StoreLocations.promenada: return 'Promenada Mall';
      case StoreLocations.sun: return 'Sun Plaza Mall';
      case StoreLocations.unirii: return 'Unirii Shopping Center';
      case StoreLocations.online: return 'Online';
    }
  }

  /// Create Empty func for clean code
  static AppointmentModel empty() => AppointmentModel(id: '', specialistId: '', userId: '', timestamp: DateTime.now(), location: StoreLocations.afi);


  /// Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'appointmentId': id,
      'specialistId': specialistId,
      'customerId': userId,
      'timestamp': timestamp,
      'location': location.toString()
    };
  }

  /// Convert model from Json structure so that you can take data in Firebase
  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['appointmentId'],
      specialistId: json['specialistId'],
      userId: json['customerId'],
      timestamp: json['timestamp'],
      location: json['location'] as StoreLocations
    );
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory AppointmentModel.fromSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;

    // Map JSON Record to the Model
    return AppointmentModel(
      id: document.id,
      specialistId: data['specialistId'] as String,
      userId: data['customerId'] as String,
      timestamp: data['timestamp'] as DateTime,
      location: StoreLocations.values.firstWhere((e) => e.toString() == data['location']),
    );
  }
}
