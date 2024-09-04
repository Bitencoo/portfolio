// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rpg_app/models/action.dart';
import 'package:rpg_app/models/action_dice.dart';

part 'action_event.dart';
part 'action_state.dart';

class ActionBloc extends Bloc<ActionEvent, ActionState> {
  ActionBloc() : super(ActionsLoading()) {
    on<LoadActionEvent>(((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      emit(ActionsLoaded(actions: [
        ActionItem(actionDices: [
          ActionDice(sizeNumber: 6, quantity: 2),
          ActionDice(sizeNumber: 20, quantity: 1)
        ], name: 'Ação A', description: 'Descrição da ação A')
      ]));
    }));
    on<CreateActionEvent>((event, emit) {
      if (state is ActionsLoaded) {
        List<ActionItem> actions = List.from((state as ActionsLoaded).actions);
        actions.add(event.action);
        emit(ActionsLoaded(actions: actions));
      }
    });
    on<DeleteActionEvent>(
      (event, emit) {
        if (state is ActionsLoaded) {
          List<ActionItem> actions =
              List.from((state as ActionsLoaded).actions);
          actions.remove(event.action);
          emit(ActionsLoaded(actions: actions));
        }
      },
    );
    on<UpdateActionEvent>(
      (event, emit) {
        if (state is ActionsLoaded) {
          List<ActionItem> actions =
              List.from((state as ActionsLoaded).actions);
          int pos = actions.indexOf(event.oldAction);
          actions.removeAt(pos);
          actions.insert(pos, event.newAction);
          emit(ActionsLoaded(actions: actions));
        }
      },
    );
  }
}
