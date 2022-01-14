import 'package:reordable_listview_task/domain/model/ext_training.dart';

import '../api/api_util.dart';
import '../../domain/model/training.dart';
import '../../domain/repository/training_repository.dart';

class TrainingDataRepository extends TrainingRepository {
  final ApiUtil _apiUtil;

  TrainingDataRepository(this._apiUtil);

  @override
  Future<List<Training>> getTrainings() {
    return _apiUtil.getTrainings();
  }

  @override
  Future<void> sendTrainings({required List<Training> trainings}) {
    return _apiUtil.sendTrainings(trainings: trainings);
  }

  @override
  Future<List<ExtTrainingList>> getExtTrainings() {
    return _apiUtil.getExtTrainings();
  }
}
