import 'dart:convert';
import 'package:rpg_app/models/action.dart';

class Character {
  final List<ActionItem> actions;
  final String name;
  final String id;
  Character({
    required this.actions,
    required this.name,
    required this.id,
  });

  Character copyWith({
    List<ActionItem>? actions,
    String? name,
    String? id,
  }) {
    return Character(
      actions: actions ?? this.actions,
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'actions': actions.map((x) => x.toMap()).toList()});
    result.addAll({'name': name});
    result.addAll({'id': id});

    return result;
  }

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      actions: List<ActionItem>.from(
          map['actions']?.map((x) => ActionItem.fromMap(x))),
      name: map['name'] ?? '',
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Character.fromJson(String source) =>
      Character.fromMap(json.decode(source));

  @override
  String toString() => 'Character(actions: $actions, name: $name, id: $id)';
}
