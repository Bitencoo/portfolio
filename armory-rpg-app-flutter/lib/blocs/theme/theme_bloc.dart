import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rpg_app/repositories/database/database_repository.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeLoading()) {
    final DatabaseRepository _databaseRepository = DatabaseRepository();
    on<LoadThemeEvent>((event, emit) async {
      ThemeType _themeType = await _databaseRepository.getThemeType();
      emit(ThemeLoaded(themeType: _themeType));
    });

    on<UpdateThemeEvent>(
      (event, emit) async {
        ThemeType _themeType =
            await _databaseRepository.updateThemeType(event.currentTheme);
        emit(ThemeLoaded(themeType: _themeType));
      },
    );
  }
}
