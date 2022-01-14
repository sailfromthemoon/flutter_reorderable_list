part of 'reorder_bloc.dart';

class ReorderState {
  final List<Training>? trainings;
  final List<List<Training>>? trainingsArchieve;

  const ReorderState({
    this.trainings,
    this.trainingsArchieve,
  });

  ReorderState copyWith({
    final List<Training>? trainings,
    final List<List<Training>>? trainingsArchieve,
  }) {
    return ReorderState(
      trainings: trainings ?? this.trainings,
      trainingsArchieve: trainingsArchieve ?? this.trainingsArchieve,
    );
  }
}
