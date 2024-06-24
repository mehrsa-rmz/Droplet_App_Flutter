import 'package:get/get.dart';
import '../../../data/repositories/product_repository.dart';
import '../models/product_ingredient_model.dart';

class ProductIngredientsController extends GetxController {
  static ProductIngredientsController get instance => Get.find();

  final ProductRepository _repository = ProductRepository();

  var productIngredients = <ProductIngredientModel>[].obs;

  Future<void> fetchProductIngredients(String productId) async {
    try {
      final ingredients = await _repository.fetchProductIngredients(productId);
      productIngredients.assignAll(ingredients);
    } catch (e) {
      print('Error fetching product ingredients: $e');
    }
  }
}
