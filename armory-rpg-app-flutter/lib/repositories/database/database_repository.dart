import 'dart:convert';
import 'package:rpg_app/blocs/theme/theme_bloc.dart';
import 'package:rpg_app/models/dice.dart';
import 'package:rpg_app/repositories/database/local_database_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/roll_history.dart';

class DatabaseRepository extends LocalDatabaseRepository {
  late SharedPreferences preferences;
  @override
  Future<List<DiceItem>> getAllDices() async {
    preferences = await SharedPreferences.getInstance();

    var dices = preferences.getStringList('dices');

    if (dices == null) {
      preferences.setStringList('dices', [
        DiceItem(sizeNumber: 4, modifier: 0).toJson(),
        DiceItem(sizeNumber: 6, modifier: 0).toJson(),
        DiceItem(sizeNumber: 8, modifier: 0).toJson(),
        DiceItem(sizeNumber: 10, modifier: 0).toJson(),
        DiceItem(sizeNumber: 20, modifier: 0).toJson(),
      ]);
      dices = preferences.getStringList('dices');
    }

    List<DiceItem> dicesList =
        dices!.map((dice) => DiceItem.fromJson(dice.toString())).toList();
    dicesList = dicesList.reversed.toList();
    return dicesList;
  }

  @override
  Future<List<DiceItem>> createDice(DiceItem dice) async {
    preferences = await SharedPreferences.getInstance();
    print(dice);
    var dices = preferences.getStringList('dices');
    if (dices != null) {
      dices.add(dice.toJson());
      preferences.setStringList('dices', dices);
    }

    List<DiceItem> dicesOnMobile =
        dices!.map((dice) => DiceItem.fromJson(dice.toString())).toList();

    return dicesOnMobile.reversed.toList();
  }

  @override
  Future<List<DiceItem>> updateDice(DiceItem dice, DiceItem newDice) async {
    preferences = await SharedPreferences.getInstance();
    var dices = preferences.getStringList('dices');
    List<DiceItem> dicesOnMobile =
        dices!.map((dice) => DiceItem.fromJson(dice.toString())).toList();
    int pos = dicesOnMobile.indexOf(dice);
    dices.removeAt(pos);
    dices.insert(pos, newDice.toJson());

    preferences.setStringList('dices', dices);

    List<DiceItem> updatedDices =
        dices.map((dice) => DiceItem.fromJson(dice.toString())).toList();

    return updatedDices.reversed.toList();
  }

  @override
  Future<List<DiceItem>> deleteDice(DiceItem dice) async {
    preferences = await SharedPreferences.getInstance();
    var dices = preferences.getStringList('dices');
    List<DiceItem> dicesOnMobile =
        dices!.map((dice) => DiceItem.fromJson(dice.toString())).toList();

    int pos = dicesOnMobile.indexOf(dice);
    dices.removeAt(pos);

    preferences.setStringList('dices', dices);

    List<DiceItem> updatedDices =
        dices.map((dice) => DiceItem.fromJson(dice.toString())).toList();

    return updatedDices.reversed.toList();
  }

  @override
  Future<List<RollHistory>> getHistory() async {
    preferences = await SharedPreferences.getInstance();

    var history = preferences.getStringList('history');
    if (history == null) {
      return [];
    }
    List<RollHistory> historyOnMobile = history
        .map((hist) => jsonDecode(hist)['type'] == 1
            ? DiceRoll.fromJson(hist.toString())
            : ActionRoll.fromJson(hist.toString()))
        .toList();

    // print('HISTORICO: ' + historyOnMobile.toString());

    return historyOnMobile.reversed.toList();
  }

  @override
  Future<void> createHistory(RollHistory historyItem) async {
    preferences = await SharedPreferences.getInstance();

    var history = preferences.getStringList('history');
    if (history != null) {
      List<RollHistory> historyOnMobile = history
          .map((hist) => jsonDecode(hist)['type'] == 1
              ? DiceRoll.fromJson(hist.toString())
              : ActionRoll.fromJson(hist.toString()))
          .toList();

      if (historyOnMobile.length >= 30) {
        history.removeAt(0);
      }
      history.add(historyItem.toJson());
      preferences.setStringList('history', history);
    } else {
      preferences.setStringList('history', [historyItem.toJson()]);
    }
    return;
  }

  Future<List<RollHistory>> deleteHistory() async {
    preferences = await SharedPreferences.getInstance();
    preferences.remove('history');
    return [];
  }

  @override
  Future<ThemeType> getThemeType() async {
    preferences = await SharedPreferences.getInstance();

    var themeType = preferences.get('themeType');
    if (themeType != null) {
      return themeType == 'Light' ? ThemeType.LIGHT : ThemeType.DARK;
    } else {
      preferences.setString('themeType', 'Light');
      return ThemeType.LIGHT;
    }
  }

  @override
  Future<ThemeType> updateThemeType(ThemeType currentThemeType) async {
    preferences = await SharedPreferences.getInstance();

    preferences.setString(
        'themeType', currentThemeType == ThemeType.LIGHT ? 'Dark' : 'Light');
    var themeType = preferences.get('themeType');
    return themeType == 'Light' ? ThemeType.LIGHT : ThemeType.DARK;
  }
}
