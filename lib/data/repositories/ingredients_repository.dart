import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import '../../features/ingredients/models/ingredient_model.dart';
import '../../utils/exceptions/firebase_exceptions.dart';
import '../../utils/exceptions/format_exceptions.dart';
import '../../utils/exceptions/platform_exceptions.dart';

class IngredientsRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<IngredientModel>> fetchIngredients() async {
    try {
      final querySnapshot = await _db.collection("Ingredients").get();
      return querySnapshot.docs.map((doc) => IngredientModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
