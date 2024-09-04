part of 'dice_bloc.dart';

abstract class DiceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DicesLoading extends DiceState {
  @override
  List<Object?> get props => [];
}

class DicesLoaded extends DiceState {
  final List<DiceItem> dices;

  DicesLoaded({
    required this.dices,
  });

  @override
  List<Object?> get props => [dices];
}

class DiceNumberGenerated extends DiceState {
  final int result;

  DiceNumberGenerated({
    required this.result,
  });

  @override
  List<Object?> get props => [result];
}
