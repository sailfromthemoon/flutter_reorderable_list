import 'dart:convert';

import '../api/model/api_training.dart';
import '../../domain/model/training.dart';

class TrainingMapper {
  static List<Training> fromApi(List<ApiTraining> apiTrainings) {
    List<Training> trainings = [];
    for (var i = 0; i < apiTrainings.length; i++) {
      // If more than one the same order entry - superset
      final bool isSuperset =
          apiTrainings.where((t) => t.order == apiTrainings[i].order).length >
              1;
      trainings.add(Training(
        id: apiTrainings[i].id,
        order: apiTrainings[i].order,
        orderPrefix: apiTrainings[i].orderPrefix,
        isSuperset: isSuperset,
      ));
    }
    return trainings;
  }

  static String toJson(List<Training> trainings) {
    final String jsonString =
        json.encode(List<dynamic>.from(trainings.map((x) => {
              "id": x.id,
              "order": x.order,
              "order_prefix": x.orderPrefix,
            })));
    return jsonString;
  }
}
