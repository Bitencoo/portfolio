import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:rpg_app/models/dice.dart';

import '../blocs/dice/dice_bloc.dart';

class DiceDialog extends StatelessWidget {
  final DiceItem? dice;
  final bool edit;
  const DiceDialog({Key? key, required this.dice, required this.edit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _textEditingController = TextEditingController();
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _textEditingControllerModifier =
        TextEditingController();
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 185,
        width: 150,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'sides'.i18n(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: const Color(0xFF2E2A2A),
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: _textEditingController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide a value';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 218, 95, 54),
                            fontWeight: FontWeight.bold,
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true),
                          cursorColor: const Color.fromARGB(255, 218, 95, 54),
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 218, 95, 54),
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            focusColor: Color.fromARGB(255, 218, 95, 54),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "modifier".i18n(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: const Color(0xFF2E2A2A),
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: _textEditingControllerModifier,
                          textAlign: TextAlign.center,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 218, 95, 54),
                              fontWeight: FontWeight.bold),
                          cursorColor: const Color.fromARGB(255, 218, 95, 54),
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 218, 95, 54),
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (_textEditingController.text.isNotEmpty &&
                    _textEditingControllerModifier.text.isNotEmpty &&
                    _textEditingController.text != '0') {
                  if (edit == true) {
                    context.read<DiceBloc>().add(
                          UpdateDiceEvent(
                              dice: dice!,
                              sizeNumber:
                                  int.parse(_textEditingController.text),
                              modifier: int.parse(
                                  _textEditingControllerModifier.text)),
                        );
                  } else {
                    context.read<DiceBloc>().add(
                          CreateDiceEvent(
                            dice: DiceItem(
                              sizeNumber:
                                  int.parse(_textEditingController.text),
                              modifier: int.parse(
                                  _textEditingControllerModifier.text),
                            ),
                          ),
                        );
                  }
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 218, 95, 54)),
              ),
              child: edit == true
                  ? Text("edit-dice".i18n())
                  : Text("create-dice".i18n()),
            ),
          ],
        ),
      ),
    );
  }
}
