import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:rpg_app/blocs/dice/dice_bloc.dart';
import 'package:rpg_app/models/dice.dart';
import 'package:rpg_app/widgets/dice_dialog.dart';
import 'package:rpg_app/widgets/dice_result_dialog.dart';

class Dice extends StatefulWidget {
  final DiceItem dice;
  const Dice({Key? key, required this.dice}) : super(key: key);

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiceBloc, DiceState>(
      builder: (context, state) {
        if (state is DicesLoaded) {
          return Material(
            color: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                GestureDetector(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.33,
                    height: 117,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 235, 84, 33),
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: const Color(0xFF2E2A2A),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text(
                            overflow: TextOverflow.visible,
                            widget.dice.modifier == 0
                                ? "D${widget.dice.sizeNumber}"
                                : widget.dice.modifier > 0
                                    ? "D${widget.dice.sizeNumber} + ${widget.dice.modifier}"
                                    : "D${widget.dice.sizeNumber} - ${widget.dice.modifier * (-1)}",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "D${widget.dice.sizeNumber}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return BlocProvider.value(
                          value: context.read<DiceBloc>(),
                          child: AlertDialog(
                            backgroundColor: Colors.transparent,
                            content: SizedBox(
                              height: 200,
                              width: 200,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 120,
                                    child: ElevatedButton.icon(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        await showDialog(
                                          context: context,
                                          builder: (_) {
                                            return BlocProvider.value(
                                              value: context.read<DiceBloc>(),
                                              child: DiceDialog(
                                                dice: widget.dice,
                                                edit: true,
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.edit),
                                      label: Text("edit".i18n()),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color.fromARGB(
                                                      255, 235, 84, 33))),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120,
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        context.read<DiceBloc>().add(
                                            DeleteDiceEvent(dice: widget.dice));
                                        Navigator.of(context).pop();
                                      },
                                      icon: const Icon(Icons.delete),
                                      label: Text("delete".i18n()),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 235, 84, 33)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return BlocProvider.value(
                          value: context.read<DiceBloc>(),
                          child: DiceResultDialog(
                            dice: widget.dice,
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30.0,
                      height: 24.0,
                      child: InkWell(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        child: Icon(
                          Icons.remove_circle,
                          color: Theme.of(context).appBarTheme.backgroundColor,
                          size: 30,
                        ),
                        onTap: () {
                          if (widget.dice.quantity > 1 &&
                              widget.dice.quantity < 50) {
                            setState(() {
                              widget.dice.quantity--;
                            });
                          }
                        },
                        onLongPress: () {
                          if (widget.dice.quantity > 0) {
                            if (widget.dice.quantity - 10 <= 0) {
                              setState(() {
                                widget.dice.quantity = 1;
                              });
                            } else {
                              setState(() {
                                widget.dice.quantity =
                                    widget.dice.quantity - 10;
                              });
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      "${widget.dice.quantity}",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    SizedBox(
                      width: 30.0,
                      height: 24.0,
                      child: InkWell(
                        child: Icon(
                          Icons.add_circle,
                          color: Theme.of(context).appBarTheme.backgroundColor,
                          size: 30,
                        ),
                        onTap: () {
                          setState(() {
                            widget.dice.quantity++;
                          });
                        },
                        onLongPress: () {
                          if (widget.dice.quantity < 50) {
                            if (widget.dice.quantity + 10 >= 50) {
                              setState(() {
                                widget.dice.quantity = 50;
                              });
                            } else {
                              setState(() {
                                widget.dice.quantity =
                                    widget.dice.quantity + 10;
                              });
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: const Color.fromARGB(255, 235, 84, 33),
            ),
          );
        }
      },
    );
  }
}
