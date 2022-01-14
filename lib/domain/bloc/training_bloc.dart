import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/training.dart';
import '../repository/training_repository.dart';
import 'training_event.dart';
import 'training_state.dart';

class TrainingBloc extends Bloc<TrainingEvent, TrainingState> {
  final TrainingRepository _trainingRepository;

  TrainingBloc(this._trainingRepository) : super(TrainingInitialState());

  @override
  Stream<TrainingState> mapEventToState(event) async* {
    if (event is TrainingsGetEvent) {
      yield* _getTrainingsToState();
    }

    if (event is TrainingsSendEvent) {
      yield* _sendTrainingsToState(trainings: event.trainings);
    }
  }

  Stream<TrainingState> _getTrainingsToState() async* {
    yield TrainingLoadingState();
    try {
      final List<Training> trainings = await _trainingRepository.getTrainings();
      yield TrainingSuccessState(trainings);
    } catch (error) {
      yield TrainingFailedState(error.toString());
    }
  }

  Stream<TrainingState> _sendTrainingsToState(
      {required List<Training> trainings}) async* {
    yield TrainingLoadingState();
    try {
      await _trainingRepository.sendTrainings(trainings: trainings);
      yield TrainingSuccessState(trainings);
    } catch (error) {
      yield TrainingFailedState(error.toString());
    }
  }
}
