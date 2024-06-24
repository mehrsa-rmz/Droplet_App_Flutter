import 'package:get/get.dart';
import '../../../data/repositories/conditions_repository.dart';
import '../models/condition_model.dart';

class ConditionsController extends GetxController {
  static ConditionsController get instance => Get.find();

  final ConditionsRepository _repository = ConditionsRepository();

  var conditions = <ConditionModel>[].obs;

  Future<void> fetchConditions() async {
    try {
      final allConditions = await _repository.fetchConditions();
      conditions.assignAll(allConditions);
    } catch (e) {
      print('Error fetching conditions: $e');
    }
  }
}
