import 'package:reordable_listview_task/data/mapper/ext_training_mapper.dart';
import 'package:reordable_listview_task/domain/model/ext_training.dart';

import 'model/api_training.dart';
import 'service/training_service.dart';
import '../mapper/training_mapper.dart';
import '../../domain/model/training.dart';

class ApiUtil {
  final TrainingService _trainingService;

  ApiUtil(this._trainingService);

  Future<List<Training>> getTrainings() async {
    final result = await _trainingService.getTrainings();
    return TrainingMapper.fromApi(result);
  }

  Future<void> sendTrainings({required List<Training> trainings}) async {
    final String apiTrainings = TrainingMapper.toJson(trainings);
    await _trainingService.sendTrainings(apiTrainings: apiTrainings);
  }

  Future<List<ExtTrainingList>> getExtTrainings() async {
    final result = await _trainingService.getTrainings();
    return ExtTrainingMapper.fromApi(result);
  }
}
