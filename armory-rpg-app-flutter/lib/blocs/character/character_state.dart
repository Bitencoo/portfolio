part of 'character_bloc.dart';

abstract class CharacterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CharactersLoading extends CharacterState {
  @override
  List<Object?> get props => [];
}

class CharactersLoaded extends CharacterState {
  final List<Character> characters;

  CharactersLoaded({
    required this.characters,
  });

  @override
  List<Object?> get props => [characters];
}
