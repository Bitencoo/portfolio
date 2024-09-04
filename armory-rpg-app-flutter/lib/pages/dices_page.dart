import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_app/blocs/dice/dice_bloc.dart';
import 'package:rpg_app/dice.dart';
import 'package:rpg_app/models/dice.dart';
import 'package:rpg_app/widgets/dice_dialog.dart';

class DicesPage extends StatefulWidget {
  final List<DiceItem> dices;
  const DicesPage({
    Key? key,
    required this.dices,
  }) : super(key: key);

  @override
  State<DicesPage> createState() => _DicesPageState();
}

class _DicesPageState extends State<DicesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiceBloc, DiceState>(
      builder: (context, state) {
        if (state is DicesLoaded) {
          return Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(1, 0, 0, 0),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: state.dices.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 10, 10, 10),
                          child: InkWell(
                            onTap: () async {
                              await showDialog(
                                context: context,
                                builder: (_) {
                                  return BlocProvider.value(
                                    value: context.read<DiceBloc>(),
                                    child: const DiceDialog(
                                      dice: null,
                                      edit: false,
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 2,
                                    color:
                                        const Color.fromARGB(255, 235, 84, 33)),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: const Color.fromARGB(255, 235, 84, 33),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 10, 10, 10),
                          child: Dice(
                            dice: state.dices[index - 1],
                          ),
                        );
                      }
                    },
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    scrollDirection: Axis.vertical,
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          );
        }
      },
    );
  }
}
