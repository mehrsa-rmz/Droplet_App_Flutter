import 'package:get/get.dart';
import '../../../data/repositories/product_repository.dart';
import '../models/product_review_model.dart';

class ProductReviewsController extends GetxController {
  static ProductReviewsController get instance => Get.find();

  final ProductRepository _repository = ProductRepository();

  var productReviews = <ProductReviewModel>[].obs;

  Future<void> fetchProductReviews(String productId) async {
    try {
      final reviews = await _repository.fetchProductReviews(productId);
      productReviews.assignAll(reviews);
    } catch (e) {
      print('Error fetching product reviews: $e');
    }
  }

  Future<void> addProductReview(ProductReviewModel review) async {
    try {
      await _repository.addProductReview(review);
      fetchProductReviews(review.productId);
    } catch (e) {
      print('Error adding product review: $e');
    }
  }
}
