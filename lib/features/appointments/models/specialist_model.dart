import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/utils/constants/enums.dart';

class SpecialistModel {
  final String id;
  final String name;
  final String title;
  final int noYearsExperience;
  final StoreLocations location;

  SpecialistModel({
    required this.id,
    required this.name,
    required this.title,
    required this.noYearsExperience,
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
  static SpecialistModel empty() => SpecialistModel(id: '', name: '', title: '', noYearsExperience: 0, location: StoreLocations.afi);


  /// Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'specialistId': id,
      'specialistName': name,
      'title': title,
      'noYearsExperience': noYearsExperience,
      'location': location.toString()
    };
  }

  /// Convert model from Json structure so that you can take data in Firebase
  factory SpecialistModel.fromJson(Map<String, dynamic> json) {
    return SpecialistModel(
      id: json['specialistId'],
      name: json['specialistName'],
      title: json['title'],
      noYearsExperience: json['noYearsExperience'],
      location: json['location'] 
    );
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory SpecialistModel.fromSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;

    // Map JSON Record to the Model
    return SpecialistModel(
      id: document.id,
      name: data['specialistName'] as String,
      title: data['title'] as String,
      noYearsExperience: data['noYearsExperience'] as int,
      location: StoreLocations.values.firstWhere((e) => e.toString() == data['location']),
    );
  }
}
