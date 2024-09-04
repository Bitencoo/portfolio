// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/character.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc() : super(CharactersLoading()) {
    on<LoadCharactersEvent>(((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      emit(CharactersLoaded(characters: const []));
    }));
    on<CreateCharacterEvent>((event, emit) {
      if (state is CharactersLoaded) {
        List<Character> characters =
            List.from((state as CharactersLoaded).characters);
        characters.add(event.character);
        emit(CharactersLoaded(characters: characters));
      }
    });
  }
}
