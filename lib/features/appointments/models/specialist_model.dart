import 'package:cloud_firestore/cloud_firestore.dart';

class SpecialistModel {
  final String id;
  final String name;
  final String title;
  final int noYearsExperience;
  final String location;

  SpecialistModel({
    required this.id,
    required this.name,
    required this.title,
    required this.noYearsExperience,
    required this.location
  });

  /// Create Empty func for clean code
  static SpecialistModel empty() => SpecialistModel(id: '', name: '', title: '', noYearsExperience: 0, location: '');


  /// Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'itemID': id,
      'specialistName': name,
      'specialistTitle': title,
      'noYearsExperience': noYearsExperience,
      'specialistLocation': location
    };
  }

  /// Convert model from Json structure so that you can take data in Firebase
  factory SpecialistModel.fromJson(Map<String, dynamic> json) {
    return SpecialistModel(
      id: json['itemID'] as String,
      name: json['specialistName'] as String,
      title: json['specialistTitle'] as String,
      noYearsExperience: json['noYearsExperience'] as int,
      location: json['specialistLocation'] as String 
    );
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory SpecialistModel.fromSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;

    // Map JSON Record to the Model
    return SpecialistModel(
      id: document.id,
      name: data['specialistName'] as String,
      title: data['specialistTitle'] as String,
      noYearsExperience: data['noYearsExperience'] as int,
      location: data['specialistLocation'] as String 
    );
  }
}
