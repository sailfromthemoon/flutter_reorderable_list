import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/bloc/reorder_bloc.dart';
import '../domain/bloc/training_bloc.dart';
import '../domain/bloc/training_event.dart';
import '../domain/bloc/training_state.dart';
import '../internal/dependencies/training_module.dart';

class ReorderableScreen extends StatefulWidget {
  const ReorderableScreen({Key? key}) : super(key: key);

  @override
  State<ReorderableScreen> createState() => _ReorderableScreenState();
}

class _ReorderableScreenState extends State<ReorderableScreen> {
  final TrainingBloc _trainingBloc = TrainingModule.trainingBloc();

  @override
  void initState() {
    super.initState();

    _trainingBloc.add(TrainingsGetEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _trainingBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reorderable'),
        centerTitle: true,
      ),
      body: Builder(builder: (context) {
        return BlocBuilder<TrainingBloc, TrainingState>(
          bloc: _trainingBloc,
          builder: (context, state) {
            if (state is TrainingLoadingState) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (state is TrainingSuccessState) {
              return BlocProvider(
                  create: (context) => ReorderBloc()
                    ..add(ReorderInitEvent(trainings: state.trainings)),
                  child: ReorderableListTile(trainingBloc: _trainingBloc));
            }
            return const SizedBox();
          },
        );
      }),
    );
  }
}

class ReorderableListTile extends StatelessWidget {
  final TrainingBloc trainingBloc;
  const ReorderableListTile({
    Key? key,
    required this.trainingBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReorderBloc, ReorderState>(
      builder: (context, state) {
        var trainingsToApi = state.trainings;
        return state.trainings == null
            ? const SizedBox()
            : Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 50,
                    child: Row(
                      children: [
                        state.trainingsArchieve!.length == 1
                            ? const SizedBox()
                            : const Text('Undo',
                                style: TextStyle(color: Colors.red)),
                        const SizedBox(width: 10),
                        state.trainingsArchieve!.length == 1
                            ? const SizedBox()
                            : IconButton(
                                icon: const Icon(
                                  Icons.refresh,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  context
                                      .read<ReorderBloc>()
                                      .add(ReorderCancelEvent());
                                },
                              ),
                        const Spacer(),
                        const Text('Send',
                            style: TextStyle(color: Colors.blue)),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            trainingBloc.add(
                                TrainingsSendEvent(trainings: trainingsToApi!));
                          },
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: ReorderableListView(
                    onReorder: (int oldIndex, int newIndex) {
                      context.read<ReorderBloc>().add(ReorderMakeEvent(
                            oldIndex: oldIndex,
                            newIndex: newIndex,
                          ));
                    },
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    children: List.generate(
                      state.trainings!.length,
                      (i) {
                        return Card(
                          color: state.trainings![i].order % 2 == 0
                              ? Colors.grey[200]
                              : Colors.white,
                          key: Key('$i'),
                          child: ListTile(
                            title:
                                Text('id ${state.trainings![i].id.toString()}'),
                            subtitle: Text(
                              state.trainings![i].isSuperset ? 'superset' : '',
                              style: const TextStyle(color: Colors.green),
                            ),
                            leading: Text(
                                ' ${state.trainings![i].order.toString()}',
                                style: const TextStyle(color: Colors.blue)),
                            trailing: Text(
                                state.trainings![i].orderPrefix.toString(),
                                style: const TextStyle(color: Colors.green)),
                            dense: true,
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
                  ))
                ],
              );
      },
    );
  }
}
