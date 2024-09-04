import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rpg_app/models/roll_history.dart';

import '../../repositories/database/database_repository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final DatabaseRepository _databaseRepository = DatabaseRepository();
  HistoryBloc() : super(HistoryLoading()) {
    on<LoadHistoryEvent>((event, emit) async {
      List<RollHistory> history = await _databaseRepository.getHistory();
      emit(HistoryLoaded(histories: history));
    });
    on<DeleteHistoryEvent>(
      (event, emit) async {
        List<RollHistory> history = await _databaseRepository.deleteHistory();
        emit(HistoryLoaded(histories: history));
      },
    );
  }
}
