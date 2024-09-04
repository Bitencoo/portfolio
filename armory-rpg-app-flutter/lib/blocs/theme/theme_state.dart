// ignore_for_file: constant_identifier_names

part of 'theme_bloc.dart';

enum ThemeType { LIGHT, DARK }

abstract class ThemeState extends Equatable {}

class ThemeLoading extends ThemeState {
  List<Object?> get props => [];
}

class ThemeLoaded extends ThemeState {
  final ThemeType themeType;

  ThemeLoaded({
    required this.themeType,
  });

  @override
  List<Object?> get props => [themeType];
}
