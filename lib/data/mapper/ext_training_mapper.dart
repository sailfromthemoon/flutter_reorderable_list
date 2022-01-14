import '../../domain/model/ext_training.dart';
import '../api/model/api_training.dart';

class ExtTrainingMapper {
  static List<ExtTrainingList> fromApi(List<ApiTraining> apiTrainings) {
    List<ExtTrainingList> trainings = [];
    for (var i = 0; i < apiTrainings.length; i++) {
      List<ExtTraining> superset = [];
      for (var t in apiTrainings) {
        if (t.order == i + 1) {
          superset.add(ExtTraining(id: t.id, orderPrefix: t.orderPrefix));
        }
      }
      trainings.add(ExtTrainingList(order: i + 1, superset: superset));
    }
    // Delete empty entries
    List<ExtTrainingList> trainingList = [];
    for (var i = 0; i < trainings.length; i++) {
      if (trainings[i].superset.isNotEmpty) {
        trainingList.add(trainings[i]);
      }
    }
    return trainings;
  }
}
