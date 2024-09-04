part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {}

class LoadThemeEvent extends ThemeEvent {
  List<Object?> get props => [];
}

class UpdateThemeEvent extends ThemeEvent {
  final ThemeType currentTheme;

  UpdateThemeEvent({
    required this.currentTheme,
  });

  List<Object?> get props => [currentTheme];
}
