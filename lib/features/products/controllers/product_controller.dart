import 'package:get/get.dart';
import '../../../data/repositories/product_repository.dart';
import '../models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final ProductRepository _repository = ProductRepository();

  var product = ProductModel.empty().obs;

  Future<void> fetchProductDetails(String productId) async {
    try {
      final productDetails = await _repository.fetchProductDetails(productId);
      product.value = productDetails;
    } catch (e) {
      print('Error fetching product details: $e');
    }
  }
}
