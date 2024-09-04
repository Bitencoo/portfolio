import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'models/action_dice.dart';

class SlidableAction extends StatelessWidget {
  final List<ActionDice> dices;
  final String actionName;
  final String actionDescription;
  const SlidableAction({
    Key? key,
    required this.dices,
    required this.actionName,
    required this.actionDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dicesString = '';
    for (int count = 0; count < dices.length; count++) {
      dicesString =
          '$dicesString ${dices[count].quantity}xD${dices[count].sizeNumber} ';
      if (count < dices.length - 1) {
        dicesString = '$dicesString + ';
      }
    }

    return Slidable(
      actionPane: const SlidableScrollActionPane(),
      secondaryActions: [
        IconSlideAction(
          caption: 'Delete',
          color: const Color(0xFFCE2929),
          icon: Icons.delete,
          onTap: () {
            // ignore: avoid_print
            print('SlidableActionWidget pressed ...');
          },
        ),
      ],
      child: ListTile(
        title: const Text(
          'Ação 01',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
        ),
        subtitle: Text(dicesString),
        tileColor: Colors.white,
        dense: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
