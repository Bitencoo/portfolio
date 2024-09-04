import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_app/blocs/history/history_bloc.dart';
import 'package:rpg_app/models/roll_history.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryBloc()..add(LoadHistoryEvent()),
      child: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoaded) {
            // If this print is removed, the color change will stop working on history page
            print(
                'rebuild b' + Theme.of(context).textTheme.headline2.toString());
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.histories.length,
                    itemBuilder: ((context, index) {
                      if (state.histories[index] is DiceRoll) {
                        return ExpansionTile(
                          collapsedIconColor:
                              Theme.of(context).appBarTheme.backgroundColor,
                          iconColor:
                              Theme.of(context).appBarTheme.backgroundColor,
                          title: Row(
                            children: [
                              Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 218, 95, 54),
                                  borderRadius: BorderRadius.circular(10),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: const Color(0xFF2E2A2A),
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                      (state.histories[index].result)
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      (state.histories[index] as DiceRoll)
                                                  .diceItem
                                                  .modifier ==
                                              0
                                          ? "${(state.histories[index] as DiceRoll).diceItem.quantity}xD${(state.histories[index] as DiceRoll).diceItem.sizeNumber}"
                                          : (state.histories[index] as DiceRoll)
                                                      .diceItem
                                                      .modifier >
                                                  0
                                              ? "${(state.histories[index] as DiceRoll).diceItem.quantity}xD${(state.histories[index] as DiceRoll).diceItem.sizeNumber} + ${(state.histories[index] as DiceRoll).diceItem.modifier}"
                                              : "${(state.histories[index] as DiceRoll).diceItem.quantity}xD${(state.histories[index] as DiceRoll).diceItem.sizeNumber} - ${(state.histories[index] as DiceRoll).diceItem.modifier * (-1)}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    '${(state.histories[index] as DiceRoll).date.toString().split(':')[0]}:${(state.histories[index] as DiceRoll).date.toString().split(':')[1]}',
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 218, 95, 54),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          ),
                          children: (state.histories[index] as DiceRoll)
                              .diceResults
                              .map(
                                (dice) => Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 64.0, top: 5.0, bottom: 5.0),
                                      child: Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 218, 95, 54),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: const Color(0xFF2E2A2A),
                                            width: 2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(dice.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "D${(state.histories[index] as DiceRoll).diceItem.sizeNumber}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            '${(state.histories[index] as DiceRoll).date.toString().split(':')[0]}:${(state.histories[index] as DiceRoll).date.toString().split(':')[1]}',
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 218, 95, 54),
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        );
                      } else {
                        return ExpansionTile(
                            tilePadding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8),
                            expandedAlignment: Alignment.center,
                            iconColor: const Color.fromARGB(255, 218, 95, 54),
                            title: Row(
                              children: [
                                Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 218, 95, 54),
                                    borderRadius: BorderRadius.circular(10),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: const Color(0xFF2E2A2A),
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      (state.histories[index].result)
                                          .toString(),
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  (state.histories[index] as ActionRoll)
                                      .actionItem
                                      .name,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ],
                            ),
                            collapsedIconColor:
                                const Color.fromARGB(255, 218, 95, 54),
                            children: (state.histories[index] as ActionRoll)
                                .actionItem
                                .actionDices
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      e.sizeNumber.toString(),
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                )
                                .toList());
                      }
                    }),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            );
          }
        },
      ),
    );
  }
}
