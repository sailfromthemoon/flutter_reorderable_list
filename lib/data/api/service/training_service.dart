import 'dart:convert';

import '../model/api_training.dart';

List<dynamic> jsonApiList = [
  {"id": 1, "order": 1, "order_prefix": ""},
  {"id": 2, "order": 2, "order_prefix": "a"},
  {"id": 3, "order": 2, "order_prefix": "b"},
  {"id": 4, "order": 2, "order_prefix": "c"},
  {"id": 5, "order": 3, "order_prefix": ""},
  {"id": 6, "order": 4, "order_prefix": ""},
  {"id": 7, "order": 5, "order_prefix": "a"},
  {"id": 8, "order": 5, "order_prefix": "b"},
];

class TrainingService {
  Future<List<ApiTraining>> getTrainings() async {
    await Future.delayed(const Duration(milliseconds: 300));
    List<ApiTraining> apiTrainings = [];
    for (var i = 0; i < jsonApiList.length; i++) {
      var item = ApiTraining.fromApi(jsonApiList[i]);
      apiTrainings.add(item);
    }
    return apiTrainings;
  }

  Future<void> sendTrainings({required String apiTrainings}) async {
    await Future.delayed(const Duration(milliseconds: 300));

    print('Trainings To Api: $apiTrainings');
  }
}
