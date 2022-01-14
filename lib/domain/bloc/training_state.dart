import '../model/training.dart';

abstract class TrainingState {}

class TrainingInitialState extends TrainingState {}

class TrainingLoadingState extends TrainingState {}

class TrainingSuccessState extends TrainingState {
  final List<Training> trainings;
  TrainingSuccessState(this.trainings);
}

class TrainingFailedState extends TrainingState {
  final String error;

  TrainingFailedState(this.error);
}
