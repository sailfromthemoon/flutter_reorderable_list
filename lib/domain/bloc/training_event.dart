import '../model/training.dart';

abstract class TrainingEvent {}

class TrainingsGetEvent extends TrainingEvent {}

class TrainingsSendEvent extends TrainingEvent {
  final List<Training> trainings;
  TrainingsSendEvent({
    required this.trainings,
  });
}

class TrainingsReorderEvent extends TrainingEvent {
  final int oldIndex;
  final int newIndex;
  final List<Training> oldTrainingList;

  TrainingsReorderEvent(
      {required this.oldIndex,
      required this.newIndex,
      required this.oldTrainingList});
}
