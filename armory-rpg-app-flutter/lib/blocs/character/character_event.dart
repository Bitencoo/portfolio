part of 'character_bloc.dart';

abstract class CharacterEvent extends Equatable {}

class LoadCharactersEvent extends CharacterEvent {
  @override
  List<Object?> get props => [];
}

class CreateCharacterEvent extends CharacterEvent {
  final Character character;

  CreateCharacterEvent({
    required this.character,
  });

  @override
  List<Object?> get props => [character];
}

class UpdateCharacterEvent extends CharacterEvent {
  final Character character;

  UpdateCharacterEvent({
    required this.character,
  });

  @override
  List<Object?> get props => [character];
}
