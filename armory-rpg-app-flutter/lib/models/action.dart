import 'dart:convert';
import 'package:rpg_app/models/action_dice.dart';

class ActionItem {
  final List<ActionDice> actionDices;
  final String name;
  final String description;

  ActionItem({
    required this.actionDices,
    required this.name,
    required this.description,
  });

  ActionItem copyWith({
    List<ActionDice>? actionDices,
    String? name,
    String? description,
  }) {
    return ActionItem(
      actionDices: actionDices ?? this.actionDices,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'actionDices': actionDices.map((x) => x.toMap()).toList()});
    result.addAll({'name': name});
    result.addAll({'description': description});

    return result;
  }

  factory ActionItem.fromMap(Map<String, dynamic> map) {
    return ActionItem(
      actionDices: List<ActionDice>.from(
          map['actionDices']?.map((x) => ActionDice.fromMap(x))),
      name: map['name'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ActionItem.fromJson(String source) =>
      ActionItem.fromMap(json.decode(source));

  @override
  String toString() =>
      'ActionItem(actionDices: $actionDices, name: $name, description: $description)';
}
