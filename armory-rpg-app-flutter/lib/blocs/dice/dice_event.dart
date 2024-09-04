part of 'dice_bloc.dart';

abstract class DiceEvent extends Equatable {}

class LoadDiceEvent extends DiceEvent {
  @override
  List<Object?> get props => [];
}

class CreateDiceEvent extends DiceEvent {
  final DiceItem dice;

  CreateDiceEvent({
    required this.dice,
  });

  @override
  List<Object?> get props => [dice];
}

class UpdateDiceEvent extends DiceEvent {
  final DiceItem dice;
  final int sizeNumber;
  final int modifier;

  UpdateDiceEvent({
    required this.dice,
    required this.sizeNumber,
    required this.modifier,
  });

  @override
  List<Object?> get props => [dice, sizeNumber, modifier];
}

class DeleteDiceEvent extends DiceEvent {
  final DiceItem dice;

  DeleteDiceEvent({
    required this.dice,
  });

  @override
  List<Object?> get props => [dice];
}

class ThrowDiceEvent extends DiceEvent {
  final DiceItem dice;

  ThrowDiceEvent({
    required this.dice,
  });

  @override
  List<Object?> get props => [dice];

  @override
  String toString() {
    return dice.toString();
  }
}

class IncrementDiceQuantityEvent extends DiceEvent {
  final DiceItem dice;

  IncrementDiceQuantityEvent({
    required this.dice,
  });

  @override
  List<Object?> get props => [dice];

  @override
  String toString() {
    return dice.toString();
  }
}
