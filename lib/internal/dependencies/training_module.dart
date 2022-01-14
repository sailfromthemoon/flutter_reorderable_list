import '../../domain/bloc/training_bloc.dart';
import 'repository_module.dart';

class TrainingModule {
  static TrainingBloc trainingBloc() {
    return TrainingBloc(
      RepositoryModule.trainingRepository(),
    );
  }
}
