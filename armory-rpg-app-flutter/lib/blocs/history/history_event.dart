part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadHistoryEvent extends HistoryEvent {
  @override
  List<Object?> get props => [];
}

class CreateHistoryEvent extends HistoryEvent {
  final RollHistory history;

  CreateHistoryEvent({
    required this.history,
  });

  @override
  List<Object?> get props => [history];
}

class DeleteHistoryEvent extends HistoryEvent {
  DeleteHistoryEvent();

  @override
  List<Object?> get props => [];
}
