part of 'history_bloc.dart';

@immutable
abstract class HistoryState extends Equatable {}

class HistoryLoading extends HistoryState {
  @override
  List<Object?> get props => [];
}

class HistoryLoaded extends HistoryState {
  final List<RollHistory> histories;

  HistoryLoaded({
    required this.histories,
  });

  @override
  List<Object?> get props => [histories];
}
