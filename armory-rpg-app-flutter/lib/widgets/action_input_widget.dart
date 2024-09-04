import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_app/blocs/dice/dice_bloc.dart';
import 'package:rpg_app/models/dice.dart';
import 'package:rpg_app/widgets/action_input_dialog.dart';

class ActionInputWidget extends StatefulWidget {
  final DiceItem dice;
  const ActionInputWidget({Key? key, required this.dice}) : super(key: key);

  @override
  State<ActionInputWidget> createState() => _ActionInputWidgetState();
}

class _ActionInputWidgetState extends State<ActionInputWidget> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _textEditingController.text = widget.dice.quantity.toString();
    return BlocProvider(
      create: (context) => DiceBloc(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 0, 0, 0),
            borderRadius: BorderRadius.circular(15),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: const Color(0xFF8823DB),
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Text(widget.dice.quantity.toString()),
              Text(
                "D${widget.dice.sizeNumber}",
                style: const TextStyle(
                    fontSize: 50, color: Color.fromARGB(255, 203, 67, 249)),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              InkWell(
                child: const Icon(
                  Icons.settings,
                  size: 60,
                  color: Colors.white,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return ActionInputDialog(
                          diceQuantity: widget.dice.quantity,
                          diceSides: widget.dice.sizeNumber,
                        );
                      });
                },
              ),
              const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Qtde. Dados",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF8823DB),
                                  borderRadius: BorderRadius.circular(50),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: const Color(0xFF2E2A2A),
                                    width: 2,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.dice.quantity--;
                                      _textEditingController.text =
                                          widget.dice.quantity.toString();
                                    });
                                  },
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 50,
                                height: 35,
                                child: TextFormField(
                                  key: Key(widget.dice.quantity.toString()),
                                  controller: _textEditingController,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                  cursorColor: const Color(0xFF8823DB),
                                  onEditingComplete: () {
                                    if (_textEditingController.text != '') {
                                      setState(() {
                                        widget.dice.quantity = int.parse(
                                            _textEditingController.text);
                                      });
                                    }
                                  },
                                  keyboardType:
                                      const TextInputType.numberWithOptions(),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF8823DB),
                                  borderRadius: BorderRadius.circular(50),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: const Color(0xFF2E2A2A),
                                    width: 2,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.dice.quantity++;
                                      _textEditingController.text =
                                          widget.dice.quantity.toString();
                                    });
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
