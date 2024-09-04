part of 'action_bloc.dart';

abstract class ActionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ActionsLoading extends ActionState {
  @override
  List<Object?> get props => [];
}

class ActionsLoaded extends ActionState {
  final List<ActionItem> actions;

  ActionsLoaded({
    required this.actions,
  });

  @override
  List<Object?> get props => [actions];
}
