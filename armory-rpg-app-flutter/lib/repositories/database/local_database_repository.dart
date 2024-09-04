import 'package:rpg_app/blocs/theme/theme_bloc.dart';
import 'package:rpg_app/models/dice.dart';
import 'package:rpg_app/models/roll_history.dart';

abstract class LocalDatabaseRepository {
  Future<List<DiceItem>> getAllDices();
  Future<List<DiceItem>> updateDice(DiceItem dice, DiceItem newDice);
  Future<List<DiceItem>> createDice(DiceItem dice);
  Future<List<DiceItem>> deleteDice(DiceItem dice);
  Future<List<RollHistory>> getHistory();
  Future<void> createHistory(RollHistory historyItem);
  Future<List<RollHistory>> deleteHistory();
  Future<ThemeType> getThemeType();
  Future<void> updateThemeType(ThemeType newThemeType);
}
