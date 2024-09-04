part of 'action_bloc.dart';

abstract class ActionEvent extends Equatable {}

class LoadActionEvent extends ActionEvent {
  @override
  List<Object?> get props => [];
}

class CreateActionEvent extends ActionEvent {
  final ActionItem action;

  CreateActionEvent({
    required this.action,
  });

  @override
  List<Object?> get props => [action];
}

class UpdateActionEvent extends ActionEvent {
  final ActionItem oldAction;
  final ActionItem newAction;

  UpdateActionEvent({required this.oldAction, required this.newAction});

  @override
  List<Object?> get props => [oldAction, newAction];
}

class DeleteActionEvent extends ActionEvent {
  final ActionItem action;

  DeleteActionEvent({
    required this.action,
  });

  @override
  List<Object?> get props => [action];
}
