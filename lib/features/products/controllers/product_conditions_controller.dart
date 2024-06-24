import 'package:get/get.dart';
import '../../../data/repositories/product_repository.dart';
import '../models/product_condition_model.dart';

class ProductConditionsController extends GetxController {
  static ProductConditionsController get instance => Get.find();

  final ProductRepository _repository = ProductRepository();

  var productConditions = <ProductConditionModel>[].obs;

  Future<void> fetchProductConditions(String productId) async {
    try {
      final conditions = await _repository.fetchProductConditions(productId);
      productConditions.assignAll(conditions);
    } catch (e) {
      print('Error fetching product conditions: $e');
    }
  }
}
