import 'dart:convert';

import 'package:rpg_app/models/action.dart';
import 'package:rpg_app/models/dice.dart';

abstract class RollHistory {
  final DateTime date;
  final int result;
  final int type;

  RollHistory({
    required this.date,
    required this.result,
    required this.type,
  });

  Map<String, dynamic> toMap();
  String toJson();
}

class DiceRoll extends RollHistory {
  final DiceItem diceItem;
  final List<int> diceResults;

  DiceRoll({
    required super.date,
    required super.result,
    super.type = 1,
    required this.diceItem,
    required this.diceResults,
  });

  @override
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'date': this.date.toIso8601String()});
    result.addAll({'result': this.result});
    result.addAll({'type': 1});
    result.addAll({'diceItem': this.diceItem.toMap()});
    result.addAll({'diceResults': this.diceResults.toList()});

    return result;
  }

  @override
  factory DiceRoll.fromMap(Map<String, dynamic> map) {
    return DiceRoll(
      date: DateTime.parse(map['date']),
      result: map['result'],
      type: 1,
      diceResults: List<int>.from(map['diceResults']),
      diceItem: DiceItem.fromMap(map['diceItem']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DiceRoll.fromJson(String source) =>
      DiceRoll.fromMap(json.decode(source));

  @override
  String toString() =>
      'DiceRoll(diceItem: $diceItem), diceResults: $diceResults';
}

class ActionRoll extends RollHistory {
  final ActionItem actionItem;
  final List<int> diceResults;

  ActionRoll({
    required super.date,
    required super.result,
    super.type = 2,
    required this.actionItem,
    required this.diceResults,
  });

  @override
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'date': this.date.toIso8601String()});
    result.addAll({'result': this.result});
    result.addAll({'type': 2});
    result.addAll({'actionItem': this.actionItem.toMap()});
    result.addAll({'diceResults': this.diceResults});

    return result;
  }

  @override
  factory ActionRoll.fromMap(Map<String, dynamic> map) {
    return ActionRoll(
      date: DateTime.parse(map['date']),
      result: map['result'],
      type: 2,
      actionItem: ActionItem.fromMap(map['actionItem']),
      diceResults: List<int>.from(map['diceResults']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ActionRoll.fromJson(String source) =>
      ActionRoll.fromMap(json.decode(source));

  @override
  String toString() =>
      'ActionRoll(actionItem: $actionItem, diceResults: $diceResults)';
}
