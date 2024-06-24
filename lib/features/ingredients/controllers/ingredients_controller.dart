import 'package:get/get.dart';
import '../../../data/repositories/ingredients_repository.dart';
import '../models/ingredient_model.dart';

class IngredientsController extends GetxController {
  static IngredientsController get instance => Get.find();

  final IngredientsRepository _repository = IngredientsRepository();

  var ingredients = <IngredientModel>[].obs;

  Future<void> fetchIngredients() async {
    try {
      final allIngredients = await _repository.fetchIngredients();
      ingredients.assignAll(allIngredients);
    } catch (e) {
      print('Error fetching ingredients: $e');
    }
  }
}
