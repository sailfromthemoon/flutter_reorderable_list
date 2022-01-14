part of 'reorder_bloc.dart';

enum SocketMessageType {
  globalChatMessage,
  directMessage,
  imageMessage,
  startDirect,
  acceptDirect,
  declineDerect,
  like,
  openModal,
  readMessages,
}

abstract class ReorderEvent {}

class ReorderInitEvent extends ReorderEvent {
  final List<Training> trainings;
  ReorderInitEvent({
    required this.trainings,
  });
}

class ReorderMakeEvent extends ReorderEvent {
  final int oldIndex;
  final int newIndex;
  ReorderMakeEvent({
    required this.oldIndex,
    required this.newIndex,
  });
}

class ReorderCancelEvent extends ReorderEvent {
  ReorderCancelEvent();
}
