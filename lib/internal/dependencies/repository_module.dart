import '../../data/repository/training_data_repository.dart';
import '../../domain/repository/training_repository.dart';
import 'api_module.dart';

class RepositoryModule {
  static final TrainingRepository _trainingRepository =
      TrainingDataRepository(ApiModule.apiUtil());

  static TrainingRepository trainingRepository() {
    return _trainingRepository;
  }
}
