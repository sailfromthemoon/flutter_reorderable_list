import 'package:reordable_listview_task/domain/model/ext_training.dart';

import '../model/training.dart';

abstract class TrainingRepository {
  Future<List<Training>> getTrainings();

  Future<void> sendTrainings({required List<Training> trainings});

  Future<List<ExtTrainingList>> getExtTrainings();
}
