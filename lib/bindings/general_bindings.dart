import 'package:get/get.dart';
import '../utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    /// -- Core
    Get.put(NetworkManager());

    /// -- Product
    // Get.put(CheckoutController());
    // Get.put(VariationController());
    // Get.put(ImagesController());

    // /// -- Other
    // Get.put(AddressController());
  }
}
