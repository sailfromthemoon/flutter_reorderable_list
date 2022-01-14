import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'training_bloc.dart';
import '../model/training.dart';

import '../../constants.dart';

part 'reorder_state.dart';
part 'reorder_event.dart';

class ReorderBloc extends Bloc<ReorderEvent, ReorderState> {
  ReorderBloc() : super(const ReorderState());

  @override
  Stream<ReorderState> mapEventToState(
    ReorderEvent event,
  ) async* {
    if (event is ReorderInitEvent) {
      yield* _initReorderToState(event.trainings);
    }
    if (event is ReorderMakeEvent) {
      yield* _makeReorderToState(event.oldIndex, event.newIndex);
    }
    if (event is ReorderCancelEvent) {
      yield* _cancelReorderToState();
    }
  }

  Stream<ReorderState> _initReorderToState(List<Training> trainings) async* {
    final List<List<Training>> newArchieve = [];
    newArchieve.insert(0, trainings.map((t) => t).toList());
    yield state.copyWith(
      trainingsArchieve: newArchieve,
      trainings: trainings,
    );
  }

  Stream<ReorderState> _cancelReorderToState() async* {
    final List<List<Training>> newArchieve = state.trainingsArchieve!;
    newArchieve.removeAt(0);
    yield state.copyWith(
      trainingsArchieve: newArchieve,
    );
    final List<Training> newTrainings =
        state.trainingsArchieve![0].map((t) => t).toList();
    yield state.copyWith(
      trainings: newTrainings,
    );
  }

  Stream<ReorderState> _makeReorderToState(int oldIndex, int newIndex) async* {
    Training item;
    List<Training> trainings = state.trainings!;

    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    // Replace training item
    item = trainings.removeAt(oldIndex);
    trainings.insert(newIndex, item);
    // Not replace if the same position
    if (newIndex != oldIndex) {
      if (
          // Item is not first
          newIndex != 0 &&
              // Item is not last
              newIndex != trainings.length - 1 &&
              // Check if superset
              trainings[newIndex - 1].order == trainings[newIndex + 1].order) {
        trainings[newIndex] = trainings[newIndex].copyWith(isSuperset: true);
      } else {
        trainings[newIndex] = trainings[newIndex].copyWith(isSuperset: false);
      }
      // Rebuild training list values
      int order = 0;
      int alphabetIndex = 0;
      for (var i = 0; i < trainings.length; i++) {
        if (trainings[i].isSuperset == false) {
          order++;
          trainings[i] = trainings[i].copyWith(order: order, orderPrefix: '');
          alphabetIndex = 0;
        } else {
          alphabetIndex == 0 ? order++ : null;
          trainings[i] = trainings[i]
              .copyWith(order: order, orderPrefix: alphabetMap[alphabetIndex]);
          alphabetIndex++;
        }
      }
      // Remove superset orderprefix if the last element in superset remains
      for (var i = 0; i < trainings.length; i++) {
        if (trainings.where((t) => t.order == trainings[i].order).length == 1) {
          trainings[i] =
              trainings[i].copyWith(orderPrefix: '', isSuperset: false);
        }
      }

      final List<List<Training>> newArchieve = state.trainingsArchieve!;
      newArchieve.insert(0, trainings.map((t) => t).toList());
      yield state.copyWith(
          trainingsArchieve: newArchieve, trainings: trainings);
    }
  }
}
