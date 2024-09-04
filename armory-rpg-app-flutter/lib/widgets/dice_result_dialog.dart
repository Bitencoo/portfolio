import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_app/blocs/dice/dice_bloc.dart';
import 'package:rpg_app/models/dice.dart';

class DiceResultDialog extends StatelessWidget {
  final DiceItem dice;
  const DiceResultDialog({Key? key, required this.dice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiceBloc()..add(ThrowDiceEvent(dice: dice)),
      child: BlocBuilder<DiceBloc, DiceState>(builder: (context, state) {
        if (state is DiceNumberGenerated) {
          print("${dice.quantity}");
          return GestureDetector(
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 218, 95, 54),
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: const Color(0xFF2E2A2A),
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(children: [
                      Text(
                        'D${dice.sizeNumber}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text(
                        state.result.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 120,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (_) {
                  return BlocProvider.value(
                    value: context.read<DiceBloc>(),
                    child: DiceResultDialog(dice: dice),
                  );
                },
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          );
        }
      }),
    );
  }
}

int generateDiceResult(int sizeNumber, int modifier) {
  int min = 1;
  int diceResult = Random().nextInt(sizeNumber - min + 1) + min + modifier;
  return diceResult;
}
