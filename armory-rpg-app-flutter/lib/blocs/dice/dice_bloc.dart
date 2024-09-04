// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:rpg_app/models/roll_history.dart';
import 'package:rpg_app/repositories/database/database_repository.dart';

import '../../models/dice.dart';

part 'dice_event.dart';
part 'dice_state.dart';

class DiceBloc extends Bloc<DiceEvent, DiceState> {
  final DatabaseRepository _databaseRepository = DatabaseRepository();
  DiceBloc() : super(DicesLoading()) {
    on<LoadDiceEvent>(((event, emit) async {
      List<DiceItem> dices = await _databaseRepository.getAllDices();
      emit(DicesLoaded(dices: dices));
    }));

    on<CreateDiceEvent>((event, emit) async {
      if (state is DicesLoaded) {
        print(event.dice.modifier);
        List<DiceItem> dices = await _databaseRepository.createDice(event.dice);
        emit(DicesLoaded(dices: dices));
      }
    });

    on<DeleteDiceEvent>(((event, emit) async {
      if (state is DicesLoaded) {
        List<DiceItem> dices = await _databaseRepository.deleteDice(event.dice);
        emit(DicesLoaded(dices: dices));
      }
    }));

    on<UpdateDiceEvent>(((event, emit) async {
      if (state is DicesLoaded) {
        List<DiceItem> dices = await _databaseRepository.updateDice(event.dice,
            DiceItem(sizeNumber: event.sizeNumber, modifier: event.modifier));
        emit(DicesLoaded(dices: dices));
      }
    }));

    on<ThrowDiceEvent>(((event, emit) async {
      int min = 1;
      int finalResult = 0;
      List<int> diceResults = [];
      int diceResult = 0;
      int auxNum = event.dice.sizeNumber;

      if (event.dice.sizeNumber <= 0) {
        auxNum = event.dice.sizeNumber * (-1);
      }

      for (int count = 0; count < event.dice.quantity; count++) {
        int diceResult = (Random().nextInt(auxNum - min + 1) + min);
        finalResult = finalResult + diceResult;
        if (event.dice.sizeNumber <= 0) {
          diceResults.add(diceResult * (-1));
        } else {
          diceResults.add(diceResult);
        }
      }

      if (event.dice.sizeNumber <= 0) {
        finalResult = finalResult * (-1);
      }

      finalResult = finalResult + event.dice.modifier;
      await _databaseRepository.createHistory(
        DiceRoll(
          date: DateTime.now(),
          result: finalResult,
          diceItem: event.dice,
          diceResults: diceResults,
        ),
      );
      emit(DiceNumberGenerated(result: finalResult));
    }));
  }
}
